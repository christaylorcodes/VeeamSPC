function Get-VeeamSPCManagementAgent {
    [CmdletBinding()]
    param(
        $AgentId
    )
    $URI = 'infrastructure/managementAgents'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}