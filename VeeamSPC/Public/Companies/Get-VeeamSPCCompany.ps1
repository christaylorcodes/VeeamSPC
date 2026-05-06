function Get-VeeamSPCCompany {
    [CmdletBinding()]
    param(
        $Expand = @('Organization')
    )
    $URI = 'organizations/companies'
    $QueryParams = @{ expand = ($Expand -join ',') }
    Invoke-VeeamSPCRequest -URI $URI -Method Get -QueryParams $QueryParams
}