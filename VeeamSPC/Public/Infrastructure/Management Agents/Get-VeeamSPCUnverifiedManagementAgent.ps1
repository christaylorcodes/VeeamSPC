function Get-VeeamSPCUnverifiedManagementAgent {
    param()
    $URI = 'infrastructure/unverifiedAgents'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}