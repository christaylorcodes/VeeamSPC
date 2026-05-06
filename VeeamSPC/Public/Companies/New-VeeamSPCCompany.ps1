function New-VeeamSPCCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $Name,
        $ExternalId,

        [Parameter(Mandatory)]
        [PSCredential]$OwnerCredentials,

        [string]$ResellerUid,
        [string]$SubscriptionPlanUid,
        [bool]$IsRestAccessEnabled = $false,
        [bool]$IsAlarmDetectEnabled = $false
    )
    $URI = '/organizations/companies'
    $BodyHash = @{
        organizationInput    = @{
            'name'    = $Name
            'country' = 1
            notes     = 'Created by ART'
            companyId = $ExternalId
        }
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
