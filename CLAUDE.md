# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`VeeamSPC` is a PowerShell wrapper around the **Veeam Service Provider Console (VSPC) REST API v3**, pinned to API version **3.6.2** via the `X-Client-Version` header. The authoritative API spec lives at [Docs/Reference/VSPC-3.6.2-OpenApi_3_0.json](Docs/Reference/VSPC-3.6.2-OpenApi_3_0.json) — consult it when adding new endpoints. The module manifest is [VeeamSPC/VeeamSPC.psd1](VeeamSPC/VeeamSPC.psd1) and targets PowerShell **3.0+**, so cross-edition (Windows PowerShell 5.1 *and* PowerShell 7+) compatibility matters.

## Module loading & exports

- [VeeamSPC/VeeamSPC.psm1](VeeamSPC/VeeamSPC.psm1) recursively dot-sources every `.ps1` under `Public/` and `Private/` at import time, then captures the manifest version into `$Script:VeeamSPCModuleVersion` (used in the User-Agent header).
- `Export-ModuleMember` exports public function basenames, **but the manifest also has an explicit `FunctionsToExport` whitelist**. Adding a new public cmdlet without adding its name to [VeeamSPC/VeeamSPC.psd1](VeeamSPC/VeeamSPC.psd1) means it won't be importable when the module is published.

## Session state & the API gateway (the central pattern)

`Connect-VeeamSPC` populates a script-scope hashtable `$Script:VeeamSPCConnection` containing `Headers` (Bearer token, `X-Client-Version`, User-Agent), `Server`, `Port`, `BaseURI` (`https://server:port/api/v3`), and `SkipCertificateCheck`. After connecting it calls `Get-VeeamSPCAbout` to validate the connection and stash `ServerVersion` / `InstallationId`.

**All API calls must go through [Invoke-VeeamSPCRequest](VeeamSPC/Public/Helpers/Invoke-VeeamSPCRequest.ps1).** Never call `Invoke-RestMethod` or `Invoke-WebRequest` directly from a cmdlet — the gateway centralises:

- Bearer auth + a per-request `X-Request-id` GUID for idempotency
- Offset-based pagination (auto-loops collections via `meta.pagingInfo`)
- HTTP 202 → returns `AsyncActionUid` parsed from the `Location` header
- 429 throttling with a custom error message
- Cross-edition `-SkipCertificateCheck` (parameter on PowerShell Core; `ServicePointManager.ServerCertificateValidationCallback` on Windows PowerShell)

## Cmdlet conventions

Three verb families with distinct shapes — match these when adding endpoints:

**`Get-*`** — minimal `[CmdletBinding()]`, optional ID parameter appended to URI, `QueryParams` hashtable for `expand` / `filter` / `sort` / `select` / `limit`. Canonical example: [Get-VeeamSPCBackupAgent.ps1](VeeamSPC/Public/Infrastructure/Backup%20Agents/Get-VeeamSPCBackupAgent.ps1).

**`New-*`** — `[CmdletBinding(SupportsShouldProcess)]` plus `[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]` (the actual `ShouldProcess` lives in `Invoke-VeeamSPCRequest`). Build the body as a nested hashtable, then `ConvertTo-Json -Depth 10`, `Method Post`. Canonical example: [New-VeeamSPCCompany.ps1](VeeamSPC/Public/Companies/New-VeeamSPCCompany.ps1).

**`Set-*`** — implements **RFC 6902 JSON Patch** with two `ParameterSetName`s:
- `Single` — `-OP` (`add|replace|test|remove|move|copy`), `-Path`, `-Value`, optional `-From`
- `Multi` — `-Multi [hashtable[]]` array of patch operations

Body is always a JSON **array**. `Method Patch`. Canonical example: [Set-VeeamSPCCompany.ps1](VeeamSPC/Public/Companies/Set-VeeamSPCCompany.ps1).

## Adding a new endpoint

1. Find the operation in [Docs/Reference/VSPC-3.6.2-OpenApi_3_0.json](Docs/Reference/VSPC-3.6.2-OpenApi_3_0.json).
2. Place the new `.ps1` under `VeeamSPC/Public/<Category>/` matching the existing folder layout (Companies, Infrastructure, Organizations, Users, Discovery, Helpers).
3. Follow the verb-family conventions above.
4. Add the function name to `FunctionsToExport` in [VeeamSPC/VeeamSPC.psd1](VeeamSPC/VeeamSPC.psd1).
5. Bump `ModuleVersion` in the manifest per the existing increment cadence.

## Build / test / lint status

None of the following are configured in-repo — do not invent commands for them:

- No Pester tests, no `Tests/` folder, no `*.Tests.ps1`.
- No `build.ps1`, psake, or InvokeBuild script.
- No `PSScriptAnalyzerSettings.psd1`.
- No GitHub Actions or other CI inside the repo (the README badges point at external AppVeyor / Codacy).

Compiled help XML lives at [VeeamSPC/en-US/VeeamSPC-help.xml](VeeamSPC/en-US/VeeamSPC-help.xml). Per [CONTRIBUTING.md](CONTRIBUTING.md) docs are built with platyPS; the per-function `.md` stubs under `Docs/` (excluding `Docs/Reference/`) are mostly placeholder.

To smoke-test changes manually:

```powershell
Import-Module ./VeeamSPC/VeeamSPC.psd1 -Force
Connect-VeeamSPC -Server <host> -Key <api-key> [-SkipCertificateCheck]
# then invoke the new cmdlet
```

## Commit conventions

From [CONTRIBUTING.md](CONTRIBUTING.md):

- Imperative mood, present tense, first line ≤72 chars.
- Add `[ci skip]` for docs-only commits.
- Optional emoji prefix per the table in `CONTRIBUTING.md` (`:bug:`, `:art:`, `:memo:`, `:fire:`, `:white_check_mark:`, `:arrow_up:`, etc.).
