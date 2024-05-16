function Set-VeeamSPCCompanyBackupResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $Company,
        [Parameter(Mandatory)]
        $Site,
        [Parameter(Mandatory)]
        $Resource,
        [ValidateSet('add', 'replace', 'test', 'remove', 'move', 'copy')]
        [Parameter(Mandatory)]
        $OP,
        [Parameter(Mandatory)]
        $Value,
        [Parameter(Mandatory)]
        $Path,
        $From
    )
    $URI = "organizations/companies/$($Company)/sites/$($Site)}/backupResources/$($Resource)"
    $Body = ConvertTo-Json -Depth 10 @(
        @{
            value = $Value
            path  = $Path
            from  = $From
            op    = $OP
        }
    )

    Invoke-VeeamSPCRequest -URI $URI -Method Patch -Body $Body
}