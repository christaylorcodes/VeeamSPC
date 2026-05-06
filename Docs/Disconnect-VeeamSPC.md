---
external help file: VeeamSPC-help.xml
Module Name: VeeamSPC
online version:
schema: 2.0.0
---

# Disconnect-VeeamSPC

## SYNOPSIS
Clears the cached VSPC session state.

## SYNTAX

```
Disconnect-VeeamSPC [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Nulls $Script:VeeamSPCConnection so subsequent cmdlets fail fast with
'Use Connect-VeeamSPC first.' Does not call any logout endpoint - the
VSPC Bearer token is server-issued and stateless on the client side.

## EXAMPLES

### EXAMPLE 1
```
Disconnect-VeeamSPC
```

## PARAMETERS

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

## OUTPUTS

## NOTES

## RELATED LINKS
