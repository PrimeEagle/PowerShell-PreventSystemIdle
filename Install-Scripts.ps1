<#
	.SYNOPSIS
	Installs prerequisites for scripts.
	
	.DESCRIPTION
	Installs prerequisites for scripts.

	.INPUTS
	None.

	.OUTPUTS
	None.

	.EXAMPLE
	PS> .\Install-Scripts
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
	Add-PathToProfile -PathVariable 'Path' -Path (Get-Location).Path
	Add-PathToProfile -PathVariable 'PSModulePath' -Path $ModulesPath
	
	Add-AliasToProfile -Script 'Prevent-SystemIdle' -Alias 'psi'
	Add-AliasToProfile -Script 'Get-PreventSystemIdleHelp' -Alias 'gpsih'
	Add-AliasToProfile -Script 'Get-PreventSystemIdleHelp' -Alias 'psihelp'
	Add-AliasToProfile -Script 'Get-PreventSystemIdleScriptVersion' -Alias 'gpsisv'
	Add-AliasToProfile -Script 'Get-PreventSystemIdleScriptVersion' -Alias 'psiver'
}

End
{
	Format-Profile
	Complete-Install
}