﻿<#
.SYNOPSIS
	Lists all branches in a Git repository
.DESCRIPTION
	This script lists all branches in a Git repository.
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working directory by default)
.PARAMETER SearchPattern
	Specifies the search patter (anything by default)
.EXAMPLE
	PS> ./list-branches
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD", [string]$SearchPattern = "*")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git -C "$RepoDir" fetch 
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	$Branches = $(git -C "$RepoDir" branch --list --remotes --no-color --no-column)
	if ($lastExitCode -ne "0") { throw "'git branch --list' failed" }

	""
	"List of Git Branches"
	"--------------------"
	foreach($Branch in $Branches) {
		if ("$Branch" -match "origin/HEAD") { continue }
		$BranchName = $Branch.substring(9)
		if ("$BranchName" -notlike "$SearchPattern") { continue }
		"$BranchName"
	}
	""
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
