function Get-VeeamSPCUser {
    [CmdletBinding()]
    param()
    $URI = 'users/logins'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}