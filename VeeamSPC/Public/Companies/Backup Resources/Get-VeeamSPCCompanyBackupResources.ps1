function Get-VeeamSPCCompanyBackupResource {
    param(
        $Company,
        $Site,
        $Resource
    )
    $URI = "organizations/companies/$($Company)/sites/$($Site)/backupResources"
    if ($Resource) { $URI = Join-Url $URI $Resource }
    
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}