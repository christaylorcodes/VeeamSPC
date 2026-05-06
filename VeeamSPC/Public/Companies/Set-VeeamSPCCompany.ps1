function Set-VeeamSPCCompany {
    <#
    .SYNOPSIS
        Applies an RFC 6902 JSON Patch to a company.

    .DESCRIPTION
        PATCH /organizations/companies/{companyUid}. Use the Single parameter set
        to apply one operation, or Multi to send an array of operations in one call.

    .PARAMETER companyUid
        UID of the company.

    .PARAMETER OP
        Patch operation: add, replace, test, remove, move, copy.

    .PARAMETER Value
        New value for add / replace / test.

    .PARAMETER From
        Source path for move / copy.

    .PARAMETER Path
        JSON Pointer path being modified.

    .PARAMETER Multi
        Array of patch hashtables (each with op/path/value/from as needed).

    .EXAMPLE
        Set-VeeamSPCCompany -companyUid $c -OP replace -Path '/name' -Value 'Acme Inc.'
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0)]
        [Alias('CompanyID')]
        [string]$companyUid,
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
    $URI = '/organizations/companies/{0}' -f $companyUid
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
