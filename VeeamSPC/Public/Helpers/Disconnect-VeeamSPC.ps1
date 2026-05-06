function Disconnect-VeeamSPC {
    <#
    .SYNOPSIS
        Clears the cached VSPC session state.

    .DESCRIPTION
        Nulls $Script:VeeamSPCConnection so subsequent cmdlets fail fast with
        'Use Connect-VeeamSPC first.' Does not call any logout endpoint - the
        VSPC Bearer token is server-issued and stateless on the client side.

    .EXAMPLE
        Disconnect-VeeamSPC
    #>
    [CmdletBinding()]
    param()
    $Script:VeeamSPCConnection = $null
}
