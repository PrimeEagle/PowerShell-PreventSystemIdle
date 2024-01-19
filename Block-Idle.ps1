<#
	.SYNOPSIS
	Short description.
	
	.DESCRIPTION
	Long description.

	.PARAMETER Drive
	Pre-defined drive name to use.
	
	.INPUTS
	Drive letter or drive label. You can pipe drive letters or drive labels as System.String.

	.OUTPUTS
	None.

	.EXAMPLE
	PS> .\mucl -Drive Music1,Music4
#>
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Requires -Version 5.0
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
param (	
	  )
DynamicParam { Build-BaseParameters }

Begin
{	
	Write-LogTrace "Execute: $(Get-RootScriptName)"
	$cmd = @{}

	if(Get-BaseParamHelpFull) { $cmd.HelpFull = $true }
	if((Get-BaseParamHelpDetail) -Or ($PSBoundParameters.Count -eq 0)) { $cmd.HelpDetail = $true }
	if(Get-BaseParamHelpSynopsis) { $cmd.HelpSynopsis = $true }
	if($cmd.Count -gt 1) { Write-DisplayHelp -Name "$(Get-RootScriptPath)" -HelpDetail }
	if($cmd.Count -eq 1) { Write-DisplayHelp -Name "$(Get-RootScriptPath)" @cmd }
}
Process
{
	try
	{
		$isDebug = Assert-Debug
		
		if(-Not (Assert-PathQueueParameter))
		{
			Write-DisplayHelp -Name "$(Get-RootScriptPath)" -HelpDetail
		}
	
		$minutes = 720

		$myshell = New-Object -com "Wscript.Shell"

		for ($i = 0; $i -lt $minutes; $i++) {
		  Start-Sleep -Seconds 180
		  $myshell.sendkeys("+")
		}
	}
	catch [System.Exception]
	{
		Write-DisplayError $PSItem.ToString() -Exit
	}
}
End
{
	Write-DisplayHost "Done." -Style Done
}
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------