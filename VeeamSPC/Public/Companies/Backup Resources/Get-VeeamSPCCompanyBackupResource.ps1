function Get-VeeamSPCCompanyBackupResource {
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
