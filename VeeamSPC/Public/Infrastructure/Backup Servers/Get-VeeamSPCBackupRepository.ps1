function Get-VeeamSPCBackupRepository {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param(
        [Parameter(ParameterSetName = 'All')]
        [Parameter(ParameterSetName = 'Server', Mandatory = $true)]
        $backupServerUid,
        [Parameter(ParameterSetName = 'Server')]
        $repositoryUid
    )

    $QueryParams = @{ expand = 'BackupRepositoryInfo' }
    $URI = '/infrastructure/backupServers/repositories'

    if ($backupServerUid) {
        $URI = "/infrastructure/backupServers/$($backupServerUid)/repositories"
        if ($repositoryUid) { $URI = "$URI/$($repositoryUid)" }
    }

    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}