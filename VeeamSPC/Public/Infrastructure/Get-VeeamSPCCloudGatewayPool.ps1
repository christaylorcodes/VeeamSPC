function Get-VeeamSPCCloudGatewayPool {
    <#
    .SYNOPSIS
        Lists cloud gateway pools.

    .DESCRIPTION
        GET /infrastructure/sites/cloudgatewaypools.

    .EXAMPLE
        Get-VeeamSPCCloudGatewayPool
    #>
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/sites/cloudgatewaypools'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
