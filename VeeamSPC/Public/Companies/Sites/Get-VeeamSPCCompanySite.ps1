function Get-VeeamSPCCompanySite {
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
