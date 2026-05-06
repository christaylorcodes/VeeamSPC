function New-VeeamSPCCompany {
    <#
    .SYNOPSIS
        Creates a new tenant company in Veeam Service Provider Console.

    .DESCRIPTION
        Sends POST /organizations/companies. Sets default company services and
        wraps owner credentials. Country defaults to 1 (USA) per VSPC's country
        enum; override via -Country.

    .PARAMETER Name
        Display name of the company.

    .PARAMETER ExternalId
        External CRM/PSA company identifier (mapped to companyId).

    .PARAMETER OwnerCredentials
        Credentials for the company portal owner account.

    .PARAMETER Country
        Numeric VSPC country code. Defaults to 1 (USA).

    .PARAMETER Notes
        Free-form notes attached to the organization record.

    .PARAMETER ResellerUid
        Optional reseller UID this company belongs to.

    .PARAMETER SubscriptionPlanUid
        Optional subscription plan UID.

    .PARAMETER IsRestAccessEnabled
        Enable VSPC REST API access for this tenant.

    .PARAMETER IsAlarmDetectEnabled
        Enable VSPC alarm detection for this tenant.

    .EXAMPLE
        New-VeeamSPCCompany -Name 'Acme' -ExternalId 'CW-1234' -OwnerCredentials (Get-Credential)
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [string]$ExternalId,

        [Parameter(Mandatory)]
        [PSCredential]$OwnerCredentials,

        [int]$Country = 1,
        [string]$Notes,
        [string]$ResellerUid,
        [string]$SubscriptionPlanUid,
        [bool]$IsRestAccessEnabled = $false,
        [bool]$IsAlarmDetectEnabled = $false
    )
    $URI = '/organizations/companies'
    $Organization = @{
        name      = $Name
        country   = $Country
        companyId = $ExternalId
    }
    if ($PSBoundParameters.ContainsKey('Notes')) { $Organization.notes = $Notes }

    $BodyHash = @{
        organizationInput    = $Organization
        companyServices      = @{
            'isBackupAgentManagementEnabled'   = $true
            'isFileLevelRestoreEnabled'        = $false
            'isBackupServerManagementEnabled'  = $true
            'isVBPublicCloudManagementEnabled' = $true
        }
        ownerCredentials     = @{
            userName = $OwnerCredentials.UserName
            password = $OwnerCredentials.GetNetworkCredential().Password
        }
        isRestAccessEnabled  = $IsRestAccessEnabled
        isAlarmDetectEnabled = $IsAlarmDetectEnabled
    }
    if ($ResellerUid) { $BodyHash.resellerUid = $ResellerUid }
    if ($SubscriptionPlanUid) { $BodyHash.subscriptionPlanUid = $SubscriptionPlanUid }

    $Body = $BodyHash | ConvertTo-Json -Depth 10
    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body $Body
}
