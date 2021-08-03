﻿<#
.SYNOPSIS
	cd-pics.ps1 
.DESCRIPTION
	Go to the user's pictures folder 
.EXAMPLE
	PS> .\cd-pics.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

$TargetDir = resolve-path "$HOME/Pictures"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, there is no folder 📂$TargetDir (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
