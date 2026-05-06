function Get-VeeamSPCUser {
    <#
    .SYNOPSIS
        Lists VSPC portal user logins.

    .DESCRIPTION
        GET /users/logins.

    .EXAMPLE
        Get-VeeamSPCUser
    #>
    [CmdletBinding()]
    param()
    $URI = 'users/logins'
    Invoke-VeeamSPCRequest -URI $URI -Method Get
}
