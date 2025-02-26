clear




$Prompt = "Select an operation below"
$Prompt += "1: Show configuration"
$Prompt += "2: Change configuration"
$Prompt += "3: Exit"

$running = $true

while($running){
    
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 3){
        Write-Host "Bye Bye!" | Out-String
        exit
        $running = $false
    }

    elif($choice -eq 2){
        
    }

    elif($choice -eq 1){

    }

    else{

    }
}