function Set-VeeamSPCManagementAgent {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $AgentID,
        [ValidateSet('add', 'replace', 'test', 'remove', 'move', 'copy')]
        [Parameter(Mandatory)]
        $OP,
        [Parameter(Mandatory)]
        [string]$Value,
        [Parameter(Mandatory)]
        $Path
    )
    $URI = "infrastructure/managementAgents/$($AgentID)"
    $Body = ConvertTo-Json @(
        @{
            value = $Value
            path  = $Path
            op    = $OP
        }
    )
    Invoke-VeeamSPCRequest -URI $URI -Method Patch -Body $Body
}