function Get-VeeamSPCBackupAgent {
    <#
    .SYNOPSIS
        Lists backup agents managed by VSPC, or returns a single agent by UID.

    .DESCRIPTION
        GET /infrastructure/backupAgents [/{AgentId}].

    .PARAMETER AgentId
        UID of a specific backup agent. Omit to return the full list.

    .EXAMPLE
        Get-VeeamSPCBackupAgent

    .EXAMPLE
        Get-VeeamSPCBackupAgent -AgentId '00000000-0000-0000-0000-000000000000'
    #>
    [CmdletBinding()]
    param(
        [string]$AgentId
    )
    $URI = 'infrastructure/backupAgents'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
