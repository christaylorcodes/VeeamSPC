function Get-VeeamSPCCloudConnectSite {
    <#
    .SYNOPSIS
        Lists Cloud Connect sites.

    .DESCRIPTION
        GET /infrastructure/sites.

    .EXAMPLE
        Get-VeeamSPCCloudConnectSite
    #>
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/sites'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
