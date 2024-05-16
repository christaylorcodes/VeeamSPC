function Get-VeeamSPCManagementAgent {
    param(
        $AgentId
    )
    $URI = 'infrastructure/managementAgents'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}