function Set-VeeamSPCOrganization {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $OrganizationID,
        [ValidateSet('add', 'replace', 'test', 'remove', 'move', 'copy')]
        [Parameter(Mandatory)]
        $OP,
        [Parameter(Mandatory)]
        [string]$Value,
        [Parameter(Mandatory)]
        $Path
    )
    $URI = "/organizations/$($OrganizationID)"
    $Body = ConvertTo-Json @(
        @{
            value = $Value
            path  = $Path
            op    = $OP
        }
    )
    Invoke-VeeamSPCRequest -URI $URI -Method Patch -Body $Body
}