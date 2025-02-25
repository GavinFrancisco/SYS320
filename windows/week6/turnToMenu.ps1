. (Join-Path $PSScriptRoot ParsingApacheLogs.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Deliverable4.ps1)


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Open/Close Google Chrome`n"
$Prompt += "5 - Exit`n"

$running = $true

while ($running){
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq "5"){
        $running = $false
        exit
    }
    elseif($choice -eq "1"){
        cd C:\Users\champuser\SYS320\windows\week4

        $test = .\WindowsApacheLogs.ps1 
        
        $test | select-object -last 10
    }
    elseif($choice -eq "2"){
        $test = getFailedLogins 90 

        $test | select-object -last 10
    }
    elseif($choice -eq "3"){
        atRiskUser 90
    }
    elseif($choice -eq "4"){
        cd C:\Users\champuser\SYS320\windows\week2
        
        .\Deliverable4.ps1
    }
    else{
        Write-Host "Unknown option. Try again"
    }
}