<#
	.SYNOPSIS
	Uninstalls prerequisites for scripts.
	
	.DESCRIPTION
	Uninstalls prerequisites for scripts.

	.INPUTS
	None.

	.OUTPUTS
	None.

	.EXAMPLE
	PS> .\Uninstall-Scripts
#>
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Requires -Version 5.0
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param ([Parameter()] [switch] $UpdateHelp,
	   [Parameter(Mandatory = $true)] [string] $ModulesPath)

Begin
{
	$script = $MyInvocation.MyCommand.Name
	if(-Not (Test-Path ".\$script"))
	{
		Write-Host "Installation must be run from the same directory as the installer script."
		exit
	}

	if(-Not (Test-Path $ModulesPath))
	{
		Write-Host "'$ModulesPath' was not found."
		exit
	}

	$Env:PSModulePath += ";$ModulesPath"
	
	Import-LocalModule Varan.PowerShell.SelfElevate
	$boundParams = @{}
	$PSCmdlet.MyInvocation.BoundParameters.GetEnumerator() | ForEach-Object { $boundParams[$_.Key] = $_.Value }
	Open-ElevatedConsole -CallerScriptPath $PSCommandPath -OriginalBoundParameters $boundParams
}

Process
{	
	Remove-PathFromProfile -PathVariable 'Path' -Path (Get-Location).Path
	
	Remove-AliasFromProfile -Script 'Prevent-SystemIdle' -Alias 'psi'
	Remove-AliasFromProfile -Script 'Get-PreventSystemIdleHelp' -Alias 'gpsih'
	Remove-AliasFromProfile -Script 'Get-PreventSystemIdleHelp' -Alias 'psihelp'
	Remove-AliasFromProfile -Script 'Get-PreventSystemIdleScriptVersion' -Alias 'gpsisv'
	Remove-AliasFromProfile -Script 'Get-PreventSystemIdleScriptVersion' -Alias 'psiver'
}

End
{
	Format-Profile
	Complete-Install
}