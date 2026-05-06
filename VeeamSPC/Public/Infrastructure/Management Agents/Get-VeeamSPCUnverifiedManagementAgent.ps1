function Get-VeeamSPCUnverifiedManagementAgent {
    <#
    .SYNOPSIS
        Lists management agents pending acceptance.

    .DESCRIPTION
        GET /infrastructure/unverifiedAgents. Pair with
        Receive-VeeamSPCUnverifiedManagementAgent to accept and assign one.

    .EXAMPLE
        Get-VeeamSPCUnverifiedManagementAgent
    #>
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/unverifiedAgents'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
