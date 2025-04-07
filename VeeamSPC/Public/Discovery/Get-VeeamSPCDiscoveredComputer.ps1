function Get-VeeamSPCDiscoveredComputer {
    [CmdletBinding()]
    param()
    $URI = 'discovery/computers'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}