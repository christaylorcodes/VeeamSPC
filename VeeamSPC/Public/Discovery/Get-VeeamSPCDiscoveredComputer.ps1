function Get-VeeamSPCDiscoveredComputer {
    <#
    .SYNOPSIS
        Lists computers discovered by the VSPC discovery service.

    .DESCRIPTION
        GET /discovery/computers.

    .EXAMPLE
        Get-VeeamSPCDiscoveredComputer
    #>
    [CmdletBinding()]
    param()
    $URI = 'discovery/computers'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
