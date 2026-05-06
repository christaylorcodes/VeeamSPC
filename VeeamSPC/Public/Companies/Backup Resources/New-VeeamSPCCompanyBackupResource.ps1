function New-VeeamSPCCompanyBackupResource {
    <#
    .SYNOPSIS
        Assigns a cloud backup resource (quota) to a tenant.

    .DESCRIPTION
        POST /infrastructure/sites/tenants/{TenantUid}/backupResources. Sets
        per-workload quotas, optional WAN acceleration, and an optional default
        flag.

    .PARAMETER TenantUid
        UID of the tenant.

    .PARAMETER RepositoryUid
        UID of the underlying repository to source the quota from.

    .PARAMETER CloudRepositoryName
        Display name for the cloud repository surfaced to the tenant.

    .PARAMETER StorageQuota
        Storage quota in bytes.

    .PARAMETER ServersQuota
        Server count quota.

    .PARAMETER IsServersQuotaUnlimited
        Treat ServersQuota as unlimited.

    .PARAMETER WorkstationsQuota
        Workstation count quota.

    .PARAMETER IsWorkstationsQuotaUnlimited
        Treat WorkstationsQuota as unlimited.

    .PARAMETER VmsQuota
        VM count quota.

    .PARAMETER IsVmsQuotaUnlimited
        Treat VmsQuota as unlimited.

    .PARAMETER IsWanAccelerationEnabled
        Enable WAN acceleration on this resource.

    .PARAMETER WanAcceleratorUid
        UID of the WAN accelerator (required when WAN acceleration is enabled).

    .PARAMETER IsDefault
        Mark as the tenant's default backup resource.

    .EXAMPLE
        New-VeeamSPCCompanyBackupResource -TenantUid $t -RepositoryUid $r -CloudRepositoryName 'Cloud' -StorageQuota 1TB
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$TenantUid,

        [Parameter(Mandatory)]
        [string]$RepositoryUid,

        [Parameter(Mandatory)]
        [string]$CloudRepositoryName,

        [Parameter(Mandatory)]
        [long]$StorageQuota,

        [int]$ServersQuota,
        [bool]$IsServersQuotaUnlimited = $true,
        [int]$WorkstationsQuota,
        [bool]$IsWorkstationsQuotaUnlimited = $true,
        [int]$VmsQuota,
        [bool]$IsVmsQuotaUnlimited = $true,
        [bool]$IsWanAccelerationEnabled = $false,
        [string]$WanAcceleratorUid,
        [bool]$IsDefault = $false
    )
    $URI = "infrastructure/sites/tenants/$TenantUid/backupResources"
    $Body = @{
        repositoryUid                = $RepositoryUid
        cloudRepositoryName          = $CloudRepositoryName
        storageQuota                 = $StorageQuota
        serversQuota                 = $ServersQuota
        isServersQuotaUnlimited      = $IsServersQuotaUnlimited
        workstationsQuota            = $WorkstationsQuota
        isWorkstationsQuotaUnlimited = $IsWorkstationsQuotaUnlimited
        vmsQuota                     = $VmsQuota
        isVmsQuotaUnlimited          = $IsVmsQuotaUnlimited
        isWanAccelerationEnabled     = $IsWanAccelerationEnabled
        wanAcceleratorUid            = $WanAcceleratorUid
        isDefault                    = $IsDefault
    } | ConvertTo-Json -Depth 10
    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body $Body
}
