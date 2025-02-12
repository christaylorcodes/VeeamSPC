﻿function Set-VeeamSPCOrganization {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0)]
        [Alias('OrganizationID')]
        $organizationUid,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [ValidateSet('add', 'replace', 'test', 'remove', 'move', 'copy')]
        $OP,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [string]$Value,
        [Parameter(ParameterSetName = 'Single')]
        [string]$From,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        $Path,
        [Parameter(Mandatory, ParameterSetName = 'Multi')]
        [hashtable[]]$Multi
    )
    $URI = '/organizations/{0}' -f $organizationUid
    if ($Multi) { $Body = ConvertTo-Json $Multi }
    else {
        $Patch = @{
            value = $Value
            path  = $Path
            op    = $OP
        }
        if ($From) { $Patch.From = $From }
        $Body = ConvertTo-Json @($Patch)
    }
    Invoke-VeeamSPCRequest -URI $URI -Method Patch -Body $Body
}