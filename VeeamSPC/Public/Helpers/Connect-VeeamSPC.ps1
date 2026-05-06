function Connect-VeeamSPC {
    <#
    .SYNOPSIS
        Establishes a session against a Veeam Service Provider Console server.

    .DESCRIPTION
        Stores connection state (Bearer token, headers, base URI, certificate
        handling) in a script-scope hashtable and validates it by calling
        Get-VeeamSPCAbout. All other VeeamSPC cmdlets read from this state.

    .PARAMETER Server
        VSPC server hostname or IP.

    .PARAMETER Port
        VSPC REST port. Defaults to 1280.

    .PARAMETER Key
        Bearer API key issued by the VSPC server.

    .PARAMETER SkipCertificateCheck
        Bypass TLS certificate validation. On Windows PowerShell 5.1 this
        installs a process-wide ServicePointManager callback.

    .EXAMPLE
        Connect-VeeamSPC -Server vspc.lab.local -Key $apiKey -SkipCertificateCheck
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Server,

        [int]$Port = 1280,

        [Parameter(Mandatory)]
        [string]$Key,

        [switch]$SkipCertificateCheck
    )

    $userAgent = "VeeamSPC-PSModule/$($Script:VeeamSPCModuleVersion) PowerShell/$($PSVersionTable.PSEdition)"

    $Script:VeeamSPCConnection = @{
        Headers              = @{
            Authorization      = "Bearer $Key"
            Accept             = 'application/json'
            'X-Client-Version' = '3.6.2'
            'User-Agent'       = $userAgent
        }
        Server               = $Server
        Port                 = $Port
        BaseURI              = "https://$($Server):$($Port)/api/v3"
        SkipCertificateCheck = [bool]$SkipCertificateCheck
    }

    try {
        $about = Get-VeeamSPCAbout -ErrorAction Stop
        $Script:VeeamSPCConnection.ServerVersion = $about.serverVersion
        $Script:VeeamSPCConnection.InstallationId = $about.installationId
    }
    catch {
        $Script:VeeamSPCConnection = $null
        throw "Connection to VSPC server $($Server):$($Port) failed - check Server, Port, and Key. $($_.Exception.Message)"
    }
}
