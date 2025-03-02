. "C:\Users\champuser\SYS320\windows\week7\Email.ps1"
. "C:\Users\champuser\SYS320\windows\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320\windows\week7\Scheduler.ps1"
. "C:\Users\champuser\SYS320\windows\week6\Event-Logs.ps1"

clear

#obtaining configuration
$config = readConfiguration

#obtaining at risk users
$Failed = atRiskUser 

#sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

#setting the script to be run daily
ChooseTimeToRun($config[1])