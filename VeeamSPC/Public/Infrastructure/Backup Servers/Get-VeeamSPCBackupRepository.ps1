function Get-VeeamSPCBackupRepository {
    <#
    .SYNOPSIS
        Lists backup repositories from VSPC, optionally scoped to a backup server.

    .DESCRIPTION
        Default: GET /infrastructure/backupServers/repositories (all).
        With -BackupServerUid: GET /infrastructure/backupServers/{uid}/repositories.
        With -RepositoryUid: appends /{repositoryUid} to return a single repo.
        Always expands BackupRepositoryInfo.

    .PARAMETER BackupServerUid
        UID of the backup server.

    .PARAMETER RepositoryUid
        UID of a specific repository under the backup server.

    .EXAMPLE
        Get-VeeamSPCBackupRepository

    .EXAMPLE
        Get-VeeamSPCBackupRepository -BackupServerUid $bs -RepositoryUid $r
    #>
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param(
        [Parameter(ParameterSetName = 'All')]
        [Parameter(ParameterSetName = 'Server', Mandatory = $true)]
        [string]$BackupServerUid,

        [Parameter(ParameterSetName = 'Server')]
        [string]$RepositoryUid
    )

    $QueryParams = @{ expand = 'BackupRepositoryInfo' }
    $URI = '/infrastructure/backupServers/repositories'

    if ($BackupServerUid) {
        $URI = "/infrastructure/backupServers/$($BackupServerUid)/repositories"
        if ($RepositoryUid) { $URI = "$URI/$($RepositoryUid)" }
    }

    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}
