function Get-VeeamSPCCompanySite {
    param(
        $Company,
        $Site,
        $Resource
    )
    $URI = 'organizations/companies/sites'
    if ($Company) {
        $URI = "organizations/companies/$($Company)/sites"
        if ($Site) {
            $URI = Join-Url $URI $Site
            if ($Resource) { $URI = Join-Url $URI $Resource }
        }
    }

    Invoke-VeeamSPCRequest -URI $URI -Method Get
}