function Get-VeeamSPCManagementAgentDownload {
    [CmdletBinding()]
    param(
        $organizationUid,
        $locationUid,
        $tokenExpiryPeriodDays = 182,
        [ValidateSet('msi', 'exe')]
        $packageType,
        [ValidateSet('x86', 'x64')]
        $osType
    )

    $URI = 'infrastructure/managementAgents/packages/windows'
    $QueryParams = @{}
    if ($organizationUid) { $QueryParams.organizationUid = $organizationUid }
    if ($locationUid) { $QueryParams.locationUid = $locationUid }
    if ($tokenExpiryPeriodDays) { $QueryParams.tokenExpiryPeriodDays = $tokenExpiryPeriodDays }
    if ($packageType) { $QueryParams.packageType = $packageType }
    if ($osType) { $QueryParams.osType = $osType }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}