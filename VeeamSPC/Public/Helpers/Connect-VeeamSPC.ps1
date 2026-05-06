function Connect-VeeamSPC {
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
            Authorization     = "Bearer $Key"
            Accept            = 'application/json'
            'X-Client-Version' = '3.6.2'
            'User-Agent'      = $userAgent
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
