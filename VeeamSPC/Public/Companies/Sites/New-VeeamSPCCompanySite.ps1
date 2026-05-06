function New-VeeamSPCCompanySite {
    <#
    .SYNOPSIS
        Creates a tenant under a Cloud Connect site.

    .DESCRIPTION
        POST /infrastructure/sites/{SiteUid}/tenants. Wraps owner credentials and
        optionally assigns the tenant to a company and gateway selection mode.

    .PARAMETER SiteUid
        UID of the Cloud Connect site to host the tenant.

    .PARAMETER Credential
        Tenant portal credentials.

    .PARAMETER CompanyUid
        UID of the company this tenant belongs to.

    .PARAMETER GatewaySelectionType
        'StandaloneGateways' or 'GatewayPool'.

    .PARAMETER GatewayPoolsUids
        UIDs of gateway pools when GatewaySelectionType is 'GatewayPool'.

    .EXAMPLE
        New-VeeamSPCCompanySite -SiteUid $s -Credential (Get-Credential) -CompanyUid $c
    #>
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

    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body ($Body | ConvertTo-Json -Depth 10)
}
