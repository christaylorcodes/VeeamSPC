function Receive-VeeamSPCUnverifiedManagementAgent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $unverifiedAgentUid,
        [Parameter(Mandatory)]
        $organizationUid
    )
    $URI = "/infrastructure/unverifiedAgents/$($unverifiedAgentUid)/accept"
    Invoke-VeeamSPCRequest -URI $URI -Method Post -QueryParams @{'organizationUid' = $organizationUid }
}