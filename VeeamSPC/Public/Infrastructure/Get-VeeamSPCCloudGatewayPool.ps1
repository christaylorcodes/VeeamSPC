function Get-VeeamSPCCloudGatewayPool {
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/sites/cloudgatewaypools'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}