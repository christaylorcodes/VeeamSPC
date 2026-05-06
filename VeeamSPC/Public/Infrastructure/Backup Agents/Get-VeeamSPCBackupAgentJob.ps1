function Get-VeeamSPCBackupAgentJob {
    <#
    .SYNOPSIS
        Lists backup agent jobs, or returns a single job by UID.

    .DESCRIPTION
        GET /infrastructure/backupAgents/jobs [/{AgentId}].

    .PARAMETER AgentId
        UID of a specific backup agent job. Omit to return all jobs.

    .EXAMPLE
        Get-VeeamSPCBackupAgentJob
    #>
    [CmdletBinding()]
    param(
        [string]$AgentId
    )
    $URI = 'infrastructure/backupAgents/jobs'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
