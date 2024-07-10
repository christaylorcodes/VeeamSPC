function New-VeeamSPCCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        $Company,
        $siteUid,
        [PSCredential]$Credential,
        $gatewaySelectionType,
        [array]$gatewayPoolsUids
    )
    $URI = "organizations/companies/$($Company)/sites"
    $Body = @{
        siteUid          = $siteUid
        ownerCredentials = @{
            userName = $Credential.UserName
            password = $Credential.GetNetworkCredential().Password
        }
    }
    if ($gatewaySelectionType) {
        $Body.gatewaySelectionType = $gatewaySelectionType
    }
    if ($gatewayPoolsUids) {
        $Body.gatewayPoolsUids = $gatewayPoolsUids
    }
    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body $($Body | ConvertTo-Json)
}