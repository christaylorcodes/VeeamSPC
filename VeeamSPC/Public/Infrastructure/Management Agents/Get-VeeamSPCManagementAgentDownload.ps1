function Get-VeeamSPCManagementAgentDownload {
    <#
    .SYNOPSIS
        Generates a download URL for a Windows management agent installer.

    .DESCRIPTION
        GET /infrastructure/managementAgents/packages/windows. Optionally scoped
        to an organization/location and parameterized by package type and OS.

    .PARAMETER OrganizationUid
        UID of the target organization.

    .PARAMETER LocationUid
        UID of the target location within the organization.

    .PARAMETER TokenExpiryPeriodDays
        Validity (days) of the deployment token embedded in the installer. Default 182.

    .PARAMETER PackageType
        Installer format: 'msi' or 'exe'.

    .PARAMETER OsType
        Target architecture: 'x86' or 'x64'.

    .EXAMPLE
        Get-VeeamSPCManagementAgentDownload -OrganizationUid $o -PackageType msi -OsType x64
    #>
    [CmdletBinding()]
    param(
        [string]$OrganizationUid,

        [string]$LocationUid,

        [int]$TokenExpiryPeriodDays = 182,

        [ValidateSet('msi', 'exe')]
        [string]$PackageType,

        [ValidateSet('x86', 'x64')]
        [string]$OsType
    )

    $URI = 'infrastructure/managementAgents/packages/windows'
    $QueryParams = @{}
    if ($OrganizationUid) { $QueryParams.organizationUid = $OrganizationUid }
    if ($LocationUid) { $QueryParams.locationUid = $LocationUid }
    if ($TokenExpiryPeriodDays) { $QueryParams.tokenExpiryPeriodDays = $TokenExpiryPeriodDays }
    if ($PackageType) { $QueryParams.packageType = $PackageType }
    if ($OsType) { $QueryParams.osType = $OsType }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}
