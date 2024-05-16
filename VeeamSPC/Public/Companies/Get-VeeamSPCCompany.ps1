function Get-VeeamSPCCompany {
    param(
        $Expand = @('Organization')
    )
    $URI = 'organizations/companies'
    $QueryParams = @{ expand = $Expand }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}