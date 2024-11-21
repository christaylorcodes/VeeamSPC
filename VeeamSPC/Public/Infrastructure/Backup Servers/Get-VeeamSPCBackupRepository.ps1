function Get-VeeamSPCBackupRepository {
    param()
    $URI = '/infrastructure/backupServers/repositories'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}