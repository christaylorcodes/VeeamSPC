---
external help file: VeeamSPC-help.xml
Module Name: VeeamSPC
online version:
schema: 2.0.0
---

# Get-VeeamSPCBackupRepository

## SYNOPSIS
Returns a collection resource representation of all Veeam Backup & Replication servers.

## SYNTAX

### All (Default)
```
Get-VeeamSPCBackupRepository [-backupServerUid <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Server
```
Get-VeeamSPCBackupRepository -backupServerUid <Object> [-repositoryUid <Object>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns a collection resource representation of all Veeam Backup & Replication servers.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-VeeamSPCBackupRepository
```

Returns a collection resource representation of all Veeam Backup & Replication servers.

## PARAMETERS

### -backupServerUid
{{ Fill backupServerUid Description }}

```yaml
Type: Object
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Object
Parameter Sets: Server
Aliases:

Required: True
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

### -repositoryUid
{{ Fill repositoryUid Description }}

```yaml
Type: Object
Parameter Sets: Server
Aliases:

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
