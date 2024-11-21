function New-VeeamSPCCompanyBackupResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [string]$companyUid,
        [string]$siteUid,
        [string]$repositoryUid,
        [string]$cloudRepositoryName,
        [long]$storageQuota,
        $serversQuota,
        $isServersQuotaUnlimited = $true,
        $workstationsQuota,
        $isWorkstationsQuotaUnlimited = $true,
        $vmsQuota,
        $isVmsQuotaUnlimited = $true,
        $isWanAccelerationEnabled = $false,
        $wanAcceleratorUid,
        $isDefault = $false
    )
    $URI = "/organizations/companies/$($companyUid)/sites/$($siteUid)/backupResources"
    $Body = @{
        repositoryUid                = $repositoryUid
        cloudRepositoryName          = $cloudRepositoryName
        storageQuota                 = $storageQuota
        serversQuota                 = $serversQuota
        isServersQuotaUnlimited      = $isServersQuotaUnlimited
        workstationsQuota            = $workstationsQuota
        isWorkstationsQuotaUnlimited = $isWorkstationsQuotaUnlimited
        vmsQuota                     = $vmsQuota
        isVmsQuotaUnlimited          = $isVmsQuotaUnlimited
        isWanAccelerationEnabled     = $isWanAccelerationEnabled
        wanAcceleratorUid            = $wanAcceleratorUid
        isDefault                    = $isDefault
    } | ConvertTo-Json -Depth 10
    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body $Body
}