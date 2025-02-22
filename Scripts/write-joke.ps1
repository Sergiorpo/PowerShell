﻿<#
.SYNOPSIS
	Writes a random Juck Norris joke to the console
.DESCRIPTION
	This script writes a random Juck Norris joke to the console.
.EXAMPLE
	PS> ./write-joke
	When Chuck Norris does division, there are no remainders. 😂
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Joke = $Table[$Index].Joke

	"$Joke 😂"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
