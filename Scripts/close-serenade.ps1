﻿<#
.SYNOPSIS
	Closes the Serenade.ai application
.DESCRIPTION
	This script closes the Serenade.ai application gracefully.
.EXAMPLE
	PS> ./close-serenade
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Serenade.ai" "serenade" ""
exit 0 # success
