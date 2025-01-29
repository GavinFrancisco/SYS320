clear 

Get-Process | select-object name, Path | Where-Object {$_.path -Notmatch "system32"}