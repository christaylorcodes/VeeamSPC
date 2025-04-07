function Get-VeeamSPCOrganization {
    [CmdletBinding()]
    param()
    $URI = 'organizations'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}