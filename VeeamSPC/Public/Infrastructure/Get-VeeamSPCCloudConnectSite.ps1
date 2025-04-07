function Get-VeeamSPCCloudConnectSite {
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/sites'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}