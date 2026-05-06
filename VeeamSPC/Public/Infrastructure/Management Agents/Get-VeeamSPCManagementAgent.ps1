function Get-VeeamSPCManagementAgent {
    <#
    .SYNOPSIS
        Lists management agents, or returns a single one by UID.

    .DESCRIPTION
        GET /infrastructure/managementAgents [/{AgentId}].

    .PARAMETER AgentId
        UID of a specific management agent.

    .EXAMPLE
        Get-VeeamSPCManagementAgent
    #>
    [CmdletBinding()]
    param(
        [string]$AgentId
    )
    $URI = 'infrastructure/managementAgents'
    if ($AgentId) { $URI = $URI + "/$AgentId" }
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
