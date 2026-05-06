function New-VeeamSPCCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$SiteUid,

        [Parameter(Mandatory)]
        [PSCredential]$Credential,

        [string]$CompanyUid,

        [ValidateSet('StandaloneGateways', 'GatewayPool')]
        [string]$GatewaySelectionType,

        [string[]]$GatewayPoolsUids
    )

    $URI = "infrastructure/sites/$SiteUid/tenants"
    $Body = @{
        credentials = @{
            userName = $Credential.UserName
            password = $Credential.GetNetworkCredential().Password
        }
    }
    if ($CompanyUid) { $Body.assignedForCompany = $CompanyUid }
    if ($GatewaySelectionType) { $Body.gatewaySelectionType = $GatewaySelectionType }
    if ($GatewayPoolsUids) { $Body.gatewayPoolsUids = $GatewayPoolsUids }

    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body ($Body | ConvertTo-Json)
}
