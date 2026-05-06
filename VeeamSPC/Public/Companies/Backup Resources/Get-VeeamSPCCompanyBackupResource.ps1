function Get-VeeamSPCCompanyBackupResource {
    <#
    .SYNOPSIS
        Lists backup resources assigned to a tenant, or fetches one by UID.

    .DESCRIPTION
        GET /infrastructure/sites/tenants/{TenantUid}/backupResources [/{ResourceUid}].

    .PARAMETER TenantUid
        UID of the tenant whose backup resources are listed.

    .PARAMETER ResourceUid
        UID of a specific backup resource.

    .EXAMPLE
        Get-VeeamSPCCompanyBackupResource -TenantUid $t
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$TenantUid,

        [string]$ResourceUid
    )

    $URI = "infrastructure/sites/tenants/$TenantUid/backupResources"
    if ($ResourceUid) { $URI = Join-Url $URI $ResourceUid }

    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
