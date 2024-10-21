---
external help file: VeeamSPC-help.xml
Module Name: VeeamSPC
online version:
schema: 2.0.0
---

# Initialize-VeeamSPCBackupAgent

## SYNOPSIS
Activate Backup Agent
Changes management mode of a Veeam backup agent with the specified UID to ManagedByConsole.

## SYNTAX

```
Initialize-VeeamSPCBackupAgent [-backupAgentUid] <Object> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> Initialize-VeeamSPCBackupAgent -backupAgentUid $Agent.instanceUid
```

Sets the backup agent to managed mode activation

## PARAMETERS

### -backupAgentUid
{{ Fill backupAgentUid Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
