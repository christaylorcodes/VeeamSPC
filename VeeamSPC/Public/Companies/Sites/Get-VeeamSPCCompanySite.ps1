function Get-VeeamSPCCompanySite {
    <#
    .SYNOPSIS
        Lists or fetches Cloud Connect site tenants.

    .DESCRIPTION
        With -TenantUid: GET /infrastructure/sites/tenants/{TenantUid} (single).
        Without: GET /infrastructure/sites/tenants. -CompanyUid filters via the
        VSPC `assignedForCompany eq` filter.

    .PARAMETER TenantUid
        UID of a specific tenant.

    .PARAMETER CompanyUid
        UID of a company - used to filter tenants assigned to that company.

    .EXAMPLE
        Get-VeeamSPCCompanySite -CompanyUid $c
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'Single', Mandatory)]
        [string]$TenantUid,

        [Parameter(ParameterSetName = 'List')]
        [string]$CompanyUid
    )

    if ($TenantUid) {
        $URI = "infrastructure/sites/tenants/$TenantUid"
        Invoke-VeeamSPCRequest -URI $URI -Method Get
        return
    }

    $URI = 'infrastructure/sites/tenants'
    $QueryParams = $null
    if ($CompanyUid) {
        $QueryParams = @{ filter = "assignedForCompany eq '$CompanyUid'" }
    }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}
