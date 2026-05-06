function Set-VeeamSPCOrganization {
    <#
    .SYNOPSIS
        Applies an RFC 6902 JSON Patch to an organization.

    .DESCRIPTION
        PATCH /organizations/{organizationUid}. Single applies one op, Multi
        applies an array of ops in one call.

    .PARAMETER organizationUid
        UID of the organization.

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
        Set-VeeamSPCOrganization -organizationUid $o -OP replace -Path '/notes' -Value 'Onboarded'
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0)]
        [Alias('OrganizationID')]
        [string]$organizationUid,
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
    $URI = '/organizations/{0}' -f $organizationUid
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
