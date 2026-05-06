function Get-VeeamSPCAbout {
    [CmdletBinding()]
    param()
    Invoke-VeeamSPCRequest -URI 'about' -Method Get
}
