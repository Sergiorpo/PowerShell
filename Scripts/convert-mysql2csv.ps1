<#
.SYNOPSIS
	convert-mysql2csv.ps1 [<server>] [<database>] [<username>] [<password>] [<query>]
.DESCRIPTION
	Convert the MySQL database table to a CSV file
.EXAMPLE
	PS> .\convert-mysql2csv.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>


param([string]$server = "", [string]$database = "", [string]$username = "", [string]$password = "", [string]$query = "")

try {
	if ($server -eq "") { $server = read-host "Enter the hostname/IP address of the MySQL server" }
	if ($database -eq "") { $database = read-host "Enter the database name" }
	if ($username -eq "") { $username = read-host "Enter the database username" }
	if ($password -eq "") { $password = read-host "Enter the database user password" }
	if ($query -eq "") { $query = read-host "Enter the database query" }

	$csvfilepath = "$PSScriptRoot\mysql_table.csv"
	$result = Invoke-MySqlQuery  -ConnectionString "server=$server; database=$database; user=$username; password=$password; pooling = false; convert zero datetime=True" -Sql $query -CommandTimeout 10000
	$result | Export-Csv $csvfilepath -NoTypeInformation
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
