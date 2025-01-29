clear

Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object | Export-Csv -Path ".\Results.csv"