function Receive-VeeamSPCUnverifiedManagementAgent {
    <#
    .SYNOPSIS
        Accepts an unverified management agent and assigns it to an organization.

    .DESCRIPTION
        Sends POST /infrastructure/unverifiedAgents/{uid}/accept with the target
        organizationUid as a query parameter. Supports -WhatIf / -Confirm.

    .PARAMETER UnverifiedAgentUid
        UID of the unverified management agent.

    .PARAMETER OrganizationUid
        UID of the organization the agent should be assigned to.

    .EXAMPLE
        Receive-VeeamSPCUnverifiedManagementAgent -UnverifiedAgentUid $a -OrganizationUid $o
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory)]
        [string]$UnverifiedAgentUid,

        [Parameter(Mandatory)]
        [string]$OrganizationUid
    )
    $URI = "/infrastructure/unverifiedAgents/$($UnverifiedAgentUid)/accept"
    Invoke-VeeamSPCRequest -URI $URI -Method Post -QueryParams @{'organizationUid' = $OrganizationUid }
}
