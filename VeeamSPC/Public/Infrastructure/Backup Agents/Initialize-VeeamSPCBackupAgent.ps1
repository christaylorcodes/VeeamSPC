function Initialize-VeeamSPCBackupAgent {
    <#
    .SYNOPSIS
        Activates a backup agent on the VSPC server.

    .DESCRIPTION
        Sends POST /infrastructure/backupAgents/{uid}/activate to mark a managed
        backup agent as active. Supports -WhatIf / -Confirm.

    .PARAMETER BackupAgentUid
        UID of the backup agent to activate.

    .EXAMPLE
        Initialize-VeeamSPCBackupAgent -BackupAgentUid '00000000-0000-0000-0000-000000000000'
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory)]
        [string]$BackupAgentUid
    )
    $URI = "/infrastructure/backupAgents/${BackupAgentUid}/activate"
    Invoke-VeeamSPCRequest -URI $URI -Method Post
}
