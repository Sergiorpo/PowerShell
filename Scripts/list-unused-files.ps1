﻿<#
.SYNOPSIS
	Lists unused files in a folder (including subfolders)
.DESCRIPTION
	This script scans and lists files in a folder with last access time older than number of days.
.PARAMETER DirTree
	Specifies the path to the directory tree
.PARAMETER Days
	Specifies the number of days
.EXAMPLE
	PS> ./list-unused-files C:\ 100
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "", [int]$Days = 100)

write-host "Listing files in $DirTree with last access time older than $Days days"

try {
	$cutOffDate = (Get-Date).AddDays(-$Days)

	Get-ChildItem -path $DirTree -recurse | Where-Object {$_.LastAccessTime -le $cutOffDate} | select fullname

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
