function Get-VeeamSPCBackupAgent {
    param(
        $AgentId
    )
    $URI = 'infrastructure/backupAgents'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}