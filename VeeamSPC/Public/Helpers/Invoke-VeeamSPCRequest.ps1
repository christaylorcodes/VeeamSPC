function Invoke-VeeamSPCRequest {
    <#
    .SYNOPSIS
        Sends a request to the Veeam Service Provider Console REST API.

    .DESCRIPTION
        Wraps Invoke-RestMethod / Invoke-WebRequest with auth headers, idempotence
        token (X-Request-id), automatic offset-based pagination for collection
        responses, and HTTP 202 / Location handling for asynchronous operations.

        Supported QueryParams keys (per spec 3.6.2): expand, filter, sort, select,
        limit, offset.

    .EXAMPLE
        Invoke-VeeamSPCRequest -URI 'organizations/companies' -Method Get -QueryParams @{ filter = "name eq 'Acme'"; limit = 50 }
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $URI,
        $Method,
        $Body,
        $QueryParams
    )
    if (!$script:VeeamSPCConnection) { throw 'Use Connect-VeeamSPC first.' }

    $Headers = @{} + $script:VeeamSPCConnection.Headers
    $Headers['X-Request-id'] = (New-Guid).Guid

    $Splat = @{
        Method      = $Method
        ContentType = 'application/json'
        Headers     = $Headers
    }
    if ($Body) {
        $Splat.Body = $Body
        Write-Verbose $Body
    }

    $isCore = $PSVersionTable.PSEdition -eq 'Core'
    if ($script:VeeamSPCConnection.SkipCertificateCheck) {
        if ($isCore) {
            $Splat.SkipCertificateCheck = $true
        }
        else {
            [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
            Write-Verbose 'Windows PowerShell: SkipCertificateCheck applied via ServicePointManager callback (process-wide).'
        }
    }

    $URL = [System.UriBuilder]$script:VeeamSPCConnection.Server
    $URL.Scheme = 'https'
    $URL.Port = $script:VeeamSPCConnection.Port
    $URL.Path = Join-URL '/api/v3' $URI

    $useWebRequest = $Method -ne 'Get'

    # Honour -WhatIf / -Confirm propagated from caller for mutating verbs only.
    if ($Method -in 'Post', 'Patch', 'Put', 'Delete') {
        if (-not $PSCmdlet.ShouldProcess($URL.Uri.OriginalString, $Method)) { return }
    }

    $Offset = 0
    $MaxIterations = 1000
    $Iteration = 0
    do {
        $Iteration++
        if ($Iteration -gt $MaxIterations) {
            Write-Warning "Pagination iteration cap ($MaxIterations) hit on $URI - aborting paginated read."
            break
        }

        $Query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        # Always send a fixed limit so the server has a predictable page size to honor.
        $Query.add('limit', 500)
        if ($Offset -gt 0) { $Query.add('offset', $Offset) }
        if ($QueryParams) {
            $QueryParams.GetEnumerator() | ForEach-Object {
                $Query.add($_.Name, $_.Value)
            }
        }
        $URL.Query = $Query.ToString()

        $Result = $null
        try {
            $prevProgressPreference = $global:ProgressPreference
            $global:ProgressPreference = 'SilentlyContinue'

            if ($useWebRequest) {
                $response = Invoke-WebRequest @Splat -Uri $URL.Uri.OriginalString -UseBasicParsing
                if ($response.StatusCode -eq 202) {
                    $location = $response.Headers['Location']
                    if ($location -is [array]) { $location = $location[0] }
                    $asyncUid = $null
                    if ($location -match '/asyncActions/([0-9a-fA-F-]+)') { $asyncUid = $Matches[1] }
                    [pscustomobject]@{
                        AsyncActionUid = $asyncUid
                        Location       = $location
                        StatusCode     = 202
                    }
                    $global:ProgressPreference = $prevProgressPreference
                    return
                }
                if ($response.Content) {
                    $Result = $response.Content | ConvertFrom-Json
                }
            }
            else {
                $Result = Invoke-RestMethod @Splat -Uri $URL.Uri.OriginalString
            }

            $global:ProgressPreference = $prevProgressPreference
        }
        catch {
            $global:ProgressPreference = $prevProgressPreference
            if ($_.Exception.Message -eq 'The remote server returned an error: (429) Too Many Requests.') {
                $PSCmdlet.ThrowTerminatingError(
                    [System.Management.Automation.ErrorRecord]::new(
                        'Throttled: Look at changing these settings: https://helpcenter.veeam.com/docs/vac/rest/throttling_config.html',
                        $_.Exception.Message,
                        [System.Management.Automation.ErrorCategory]::ProtocolError,
                        $null
                    )
                )
            }
            else { $PSCmdlet.ThrowTerminatingError($_) }
        }

        if ($Result.meta.pagingInfo) { Write-Verbose $Result.meta.pagingInfo }

        # Detect non-advancing pagination: if the server echoes back an offset that doesn't match
        # what we sent, or the next offset wouldn't advance, break instead of spinning forever
        # (some filter/expand combos cause the server to ignore offset and re-serve the first page).
        $ServerOffset = $Result.meta.pagingInfo.offset
        if ($null -ne $ServerOffset -and $Offset -gt 0 -and $ServerOffset -ne $Offset) {
            Write-Warning "VSPC pagination ignored offset on $URI (sent $Offset, server returned $ServerOffset). Returning current page only to avoid duplicate results."
            $Result.data
            break
        }

        $NextOffset = $Result.meta.pagingInfo.count + $Result.meta.pagingInfo.offset
        if ($NextOffset -le $Offset) {
            $Result.data
            break
        }
        $Offset = $NextOffset
        $Result.data
    }
    while ($Result.meta -and $Result.meta.pagingInfo.count + $Result.meta.pagingInfo.offset -lt $Result.meta.pagingInfo.total)
}
