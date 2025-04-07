function Get-VeeamSPCBackupAgentJob {
    [CmdletBinding()]
    param(
        $AgentId
    )
    $URI = 'infrastructure/backupAgents/jobs'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}