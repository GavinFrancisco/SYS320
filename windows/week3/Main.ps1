. (Join-Path $PSScriptRoot FunctionsAndEventLogs.ps1)

clear

# Get Login and Logoffs from the last 15 days
getEventLogs 15
# Get shut down from the last 25 days
getOnOffLogs 6006 25
# Get start up from the last 25 days
getOnOffLogs 6005 25