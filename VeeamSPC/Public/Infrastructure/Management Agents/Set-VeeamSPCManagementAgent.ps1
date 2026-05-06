function Set-VeeamSPCManagementAgent {
    <#
    .SYNOPSIS
        Applies an RFC 6902 JSON Patch to a management agent.

    .DESCRIPTION
        PATCH /infrastructure/managementAgents/{managementAgentUid}. Single
        applies one op, Multi applies an array of ops in one call.

    .PARAMETER managementAgentUid
        UID of the management agent.

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
        Set-VeeamSPCManagementAgent -managementAgentUid $a -OP replace -Path '/locationUid' -Value $loc
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Single', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'Multi', Position = 0)]
        [Alias('AgentID')]
        [string]$managementAgentUid,
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
    $URI = '/infrastructure/managementAgents/{0}' -f $managementAgentUid
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
