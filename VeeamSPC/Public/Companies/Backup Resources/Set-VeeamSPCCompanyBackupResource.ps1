function Set-VeeamSPCCompanyBackupResource {
    <#
    .SYNOPSIS
        Applies an RFC 6902 JSON Patch to a tenant's backup resource.

    .DESCRIPTION
        PATCH /infrastructure/sites/tenants/{TenantUid}/backupResources/{ResourceUid}.
        Single applies one op, Multi applies an array of ops in one call.

    .PARAMETER TenantUid
        UID of the tenant.

    .PARAMETER ResourceUid
        UID of the backup resource.

    .PARAMETER OP
        Patch operation: add, replace, test, remove, move, copy.

    .PARAMETER Value
        New value for add / replace / test.

    .PARAMETER From
        Source path for move / copy.

    .PARAMETER Path
        JSON Pointer path being modified.

    .PARAMETER Multi
        Array of patch hashtables.

    .EXAMPLE
        Set-VeeamSPCCompanyBackupResource -TenantUid $t -ResourceUid $r -OP replace -Path '/storageQuota' -Value '5497558138880'
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0)]
        [string]$TenantUid,
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 1)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 1)]
        [Alias('Resource')]
        [string]$ResourceUid,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [ValidateSet('add', 'replace', 'test', 'remove', 'move', 'copy')]
        [string]$OP,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [string]$Value,
        [Parameter(ParameterSetName = 'Single')]
        [string]$From,
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Mandatory, ParameterSetName = 'Multi')]
        [hashtable[]]$Multi
    )
    $URI = 'infrastructure/sites/tenants/{0}/backupResources/{1}' -f $TenantUid, $ResourceUid
    if ($Multi) { $Body = ConvertTo-Json $Multi -Depth 10 }
    else {
        $Patch = @{
            value = $Value
            path  = $Path
            op    = $OP
        }
        if ($From) { $Patch.From = $From }
        $Body = ConvertTo-Json @($Patch) -Depth 10
    }
    Invoke-VeeamSPCRequest -URI $URI -Method Patch -Body $Body
}
