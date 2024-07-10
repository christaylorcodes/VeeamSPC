function Get-VeeamSPCCloudGatewayPool {
    param()
    $URI = 'infrastructure/sites/cloudgatewaypools'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}