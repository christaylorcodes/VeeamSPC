function Get-VeeamSPCAbout {
    <#
    .SYNOPSIS
        Returns server info (version, installation id) for the connected VSPC.

    .DESCRIPTION
        GET /api/v3/about. Used by Connect-VeeamSPC to validate the session and
        cache server metadata.

    .EXAMPLE
        Get-VeeamSPCAbout
    #>
    [CmdletBinding()]
    param()
    Invoke-VeeamSPCRequest -URI 'about' -Method Get
}
