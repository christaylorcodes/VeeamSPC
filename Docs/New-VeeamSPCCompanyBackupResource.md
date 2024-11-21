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
New-VeeamSPCCompanyBackupResource [[-companyUid] <String>] [[-siteUid] <String>] [[-repositoryUid] <String>]
 [[-cloudRepositoryName] <String>] [[-storageQuota] <Int64>] [[-serversQuota] <Object>]
 [[-isServersQuotaUnlimited] <Object>] [[-workstationsQuota] <Object>]
 [[-isWorkstationsQuotaUnlimited] <Object>] [[-vmsQuota] <Object>] [[-isVmsQuotaUnlimited] <Object>]
 [[-isWanAccelerationEnabled] <Object>] [[-wanAcceleratorUid] <Object>] [[-isDefault] <Object>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
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

### -cloudRepositoryName
{{ Fill cloudRepositoryName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyUid
{{ Fill companyUid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isDefault
{{ Fill isDefault Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isServersQuotaUnlimited
{{ Fill isServersQuotaUnlimited Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isVmsQuotaUnlimited
{{ Fill isVmsQuotaUnlimited Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isWanAccelerationEnabled
{{ Fill isWanAccelerationEnabled Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isWorkstationsQuotaUnlimited
{{ Fill isWorkstationsQuotaUnlimited Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -repositoryUid
{{ Fill repositoryUid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serversQuota
{{ Fill serversQuota Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteUid
{{ Fill siteUid Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -storageQuota
{{ Fill storageQuota Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmsQuota
{{ Fill vmsQuota Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wanAcceleratorUid
{{ Fill wanAcceleratorUid Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workstationsQuota
{{ Fill workstationsQuota Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
