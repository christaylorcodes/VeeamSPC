function Get-VeeamSPCManagementAgentDownload {
    param(
        $organizationUid,
        $locationUid,
        $tokenExpiryPeriodDays = 182,
        [ValidateSet('msi', 'exe')]
        $packageType,
        [ValidateSet('x86', 'x64')]
        $osType,
        $OutputPath
    )

    $URI = 'infrastructure/managementAgents/packages/windows'
    $QueryParams = @{
        organizationUid       = $organizationUid
        locationUid           = $locationUid
        tokenExpiryPeriodDays = $tokenExpiryPeriodDays
        packageType           = $packageType
        osType                = $osType
        OutputPath            = $OutputPath
    }    
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}