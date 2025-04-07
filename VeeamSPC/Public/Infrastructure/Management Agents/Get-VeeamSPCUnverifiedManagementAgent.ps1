function Get-VeeamSPCUnverifiedManagementAgent {
    [CmdletBinding()]
    param()
    $URI = 'infrastructure/unverifiedAgents'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}