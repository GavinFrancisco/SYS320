clear


function readConfiguration(){
    $Config = Get-Content -Path C:\Users\champuser\SYS320\windows\week7\configuration.txt

    $ConfigTable = @()

    $ConfigTable += [pscustomobject]@{"Days" = $Config[0]; "Execution Time" = $Config[1]}

    return $ConfigTable
}

function changeConfiguration($days,$ExTi){
    $newData = @($days,$ExTi)

    $newData | Out-File -FilePath C:\Users\champuser\SYS320\windows\week7\configuration.txt
}

function configurationMenu(){
    $Prompt = "`n"
    $Prompt += "Select an operation below `n"
    $Prompt += "1: Show configuration `n"
    $Prompt += "2: Change configuration `n"
    $Prompt += "3: Exit"
}


$running = $true

while($running){
    
    configurationMenu

    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 3){
        Write-Host "Bye Bye!" | Out-String
        exit
        $running = $false
    }

    elseif($choice -eq 2){
        $days = Read-Host -Prompt "Enter the amount of days for which the logs will be obtained: "
        $ExTi = Read-Host -Prompt "Enter the daily execution time (should be like 12:34 AM/PM): "

        if(($days -match '^-?\d+(\.\d+)?$') -and ($ExTi -match "([0-1]?[0-9]):[0-5][0-9] (AM|PM|am|pm)")){
            changeConfiguration $days $ExTi
        }
        else{
            Write-Host "Improper format, please try again"
        }
    }

    elseif($choice -eq 1){
        $output = readConfiguration

        Write-Host ($output | Format-Table | Out-String)
    }

    else{
        Write-Host "Invaild input, try again"
    }
}