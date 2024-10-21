function Initialize-VeeamSPCBackupAgent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $backupAgentUid
    )
    $URI = "/infrastructure/backupAgents/${backupAgentUid}/activate"
    Invoke-VeeamSPCRequest -URI $URI -Method Post
}