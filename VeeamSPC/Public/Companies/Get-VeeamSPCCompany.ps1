function Get-VeeamSPCCompany {
    <#
    .SYNOPSIS
        Lists tenant companies.

    .DESCRIPTION
        GET /organizations/companies. Defaults to expanding the Organization
        sub-resource (matches what most callers want); pass -Expand to override.

    .PARAMETER Expand
        VSPC expand keywords (e.g. 'Organization'). Joined with commas.

    .EXAMPLE
        Get-VeeamSPCCompany

    .EXAMPLE
        Get-VeeamSPCCompany -Expand Organization,Site
    #>
    [CmdletBinding()]
    param(
        [string[]]$Expand = @('Organization')
    )
    $URI = 'organizations/companies'
    $QueryParams = @{ expand = ($Expand -join ',') }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}
