function Receive-VeeamSPCUnverifiedManagementAgent {
    param(
        $AgentId
    )
    $URI = "infrastructure/unverifiedAgents/$($AgentId)/accept"
    Invoke-VeeamSPCRequest -URI $URI -Method Post
}