﻿<#
.SYNOPSIS
	Search and replace a pattern in the given files by the replacement
.DESCRIPTION
	This script searches and replaces a pattern in the given files by the replacement.
.PARAMETER pattern
	Specifies the pattern to look for
.PARAMETER replacement
	Specifies the replacement
.PARAMETER files
	Specifies the file to scan
.EXAMPLE
	PS> ./replace-in-files NSA "No Such Agency" C:\Temp\*.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$pattern = "", [string]$replacement = "", [string]$files = "")

function ReplaceInFile { param([string]$FilePath, [string]$Pattern, [string]$Replacement)

    [System.IO.File]::WriteAllText($FilePath,
        ([System.IO.File]::ReadAllText($FilePath) -replace $Pattern, $Replacement)
    )
}

try {
	if ($pattern -eq "" ) { $pattern = read-host "Enter search pattern" }
	if ($replacement -eq "" ) { $replacement = read-host "Enter replacement" }
	if ($files -eq "" ) { $files = read-host "Enter files" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$fileList = (get-childItem -path "$files" -attributes !Directory)
	foreach($file in $fileList) {
		ReplaceInFile $file $pattern $replacement
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ replaced '$pattern' by '$replacement' in $($fileList.Count) files in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
