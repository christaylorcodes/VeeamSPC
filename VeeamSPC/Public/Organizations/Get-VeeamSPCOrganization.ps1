function Get-VeeamSPCOrganization {
    <#
    .SYNOPSIS
        Lists organizations.

    .DESCRIPTION
        GET /organizations.

    .EXAMPLE
        Get-VeeamSPCOrganization
    #>
    [CmdletBinding()]
    param()
    $URI = 'organizations'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
