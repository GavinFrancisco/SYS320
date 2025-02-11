. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot ParsingApacheLogs.ps1)

clear

#Testing WindowsApacheLogs
apache-logs shrekfart 404 chrome

#Testing ParsingApacheLogs
$testing = apacheLogFilter
$testing | Format-Table -AutoSize -Wrap