---
external help file: VeeamSPC-help.xml
Module Name: VeeamSPC
online version:
schema: 2.0.0
---

# New-VeeamSPCCompanyBackupResource

## SYNOPSIS
Allocate a new cloud backup resource to a company with the specified UID.

## SYNTAX

```
New-VeeamSPCCompanyBackupResource [-TenantUid] <String> [-RepositoryUid] <String>
 [-CloudRepositoryName] <String> [-StorageQuota] <Int64> [[-ServersQuota] <Int32>]
 [[-IsServersQuotaUnlimited] <Boolean>] [[-WorkstationsQuota] <Int32>]
 [[-IsWorkstationsQuotaUnlimited] <Boolean>] [[-VmsQuota] <Int32>] [[-IsVmsQuotaUnlimited] <Boolean>]
 [[-IsWanAccelerationEnabled] <Boolean>] [[-WanAcceleratorUid] <String>] [[-IsDefault] <Boolean>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allocate a new cloud backup resource to a company with the specified UID.

## EXAMPLES

### Example 1
```powershell
PS C:\> $RepoSplat = @{
    companyUid          = $Company.instanceUid
    siteUid             = $Site.siteUid 
    repositoryUid       = $Repo.instanceUid
    cloudRepositoryName = $Repo.name
    storageQuota        = 1TB
    isDefault           = $true
}
New-VeeamSPCCompanyBackupResource @RepoSplat
```

Assigns a repository as a backup resource for a company/site. Give it a quota and set it as default.

## PARAMETERS

### -TenantUid
UID of the tenant.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepositoryUid
{{ Fill repositoryUid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CloudRepositoryName
{{ Fill cloudRepositoryName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StorageQuota
{{ Fill storageQuota Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServersQuota
{{ Fill serversQuota Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsServersQuotaUnlimited
{{ Fill isServersQuotaUnlimited Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkstationsQuota
{{ Fill workstationsQuota Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsWorkstationsQuotaUnlimited
{{ Fill isWorkstationsQuotaUnlimited Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VmsQuota
{{ Fill vmsQuota Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsVmsQuotaUnlimited
{{ Fill isVmsQuotaUnlimited Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsWanAccelerationEnabled
{{ Fill isWanAccelerationEnabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WanAcceleratorUid
{{ Fill wanAcceleratorUid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDefault
{{ Fill isDefault Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
