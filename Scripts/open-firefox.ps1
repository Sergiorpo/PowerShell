﻿<#
.SYNOPSIS
	Launches the Firefox browser
.DESCRIPTION
	This script launches the Mozilla Firefox Web browser.
.EXAMPLE
	PS> ./open-firefox
.PARAMETER URL
	Specifies an URL
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$URL = "http://www.fleschutz.de")

try {
	$App = Get-AppxPackage -Name Mozilla.FireFox
	if ($App.Status -eq "Ok") {
		# starting Firefox UWP app:
		explorer.exe shell:appsFolder\$($App.PackageFamilyName)!FIREFOX
	} else {
		# starting Firefox program:
		start-process firefox.exe "$URL"
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
