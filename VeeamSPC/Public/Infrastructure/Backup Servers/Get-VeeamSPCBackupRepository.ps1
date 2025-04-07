﻿function Get-VeeamSPCBackupRepository {
    [CmdletBinding()]
    param()
    $URI = '/infrastructure/backupServers/repositories'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}