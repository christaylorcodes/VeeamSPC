function New-VeeamSPCCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        $Company,
        $siteUid,
        [PSCredential]$Credential
    )
    $URI = "organizations/companies/$($Company)/sites"
    $Body = @{
        siteUid          = $siteUid
        ownerCredentials = @{
            userName = $Credential.UserName
            password = $Credential.GetNetworkCredential().Password
        }
    } | ConvertTo-Json -Depth 10
    Invoke-VeeamSPCRequest -URI $URI -Method Post -Body $Body
}