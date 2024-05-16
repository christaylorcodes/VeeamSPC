function Invoke-VeeamSPCRequest {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $URI,
        $Method,
        $Body,
        $QueryParams
    )
    if (!$script:VeeamSPCConnection) { throw 'Use Connect-VeeamSPC first.' }

    $Splat = @{
        Method      = $Method
        ContentType = 'application/json'
        Headers     = $script:VeeamSPCConnection.Headers
    }
    if ($Body) {
        $Splat.Body = $Body
        Write-Verbose $Body
    }

    $URL = [System.UriBuilder]$script:VeeamSPCConnection.Server
    $URL.Scheme = 'https'
    $URL.Port = $script:VeeamSPCConnection.Port
    $URL.Path = Join-URL '/api/v3' $URI

    $Offset = 0
    do {
        $Query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        if ($Offset -gt 0) { $Query.add('offset', $Offset) }
        if ($QueryParams) {
            $QueryParams.GetEnumerator() | ForEach-Object {
                $Query.add($_.Name, $_.Value)
            }
        }
        $URL.Query = $Query.ToString()
        try {
            $Result = Invoke-RestMethod @Splat -Uri $URL.Uri.OriginalString
        }
        catch {
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
            else { $_ }
        }

        if ($Result.meta.pagingInfo) { Write-Verbose $Result.meta.pagingInfo }
        $Offset = $Result.meta.pagingInfo.count + $Result.meta.pagingInfo.offset
        # Needed to adjust throttle settings
        # https://helpcenter.veeam.com/docs/vac/rest/throttling.html
        # if ($Offset -gt 0) { Start-Sleep -Milliseconds 500 }
        $Result.data
    }
    while ($Result.meta -and $Result.meta.pagingInfo.count + $Result.meta.pagingInfo.offset -lt $Result.meta.pagingInfo.total)
}