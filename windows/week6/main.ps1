. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get at risk users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user - done
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        $checkUser = $false
        $checkPass = $false

        $checkUser = checkUser $name

        $checkPass = checkpassword $password

        if($checkUser -and $checkPass){
            createAUser $name $password
            Write-Host "User: $name is created." | Out-String
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # checkUser function - done

        $check = checkuserExist $name

        if($check){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "User not found"
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        #checkUser function - done

        $check = checkUserExist $name

        if($check){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "User not found"
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        #checkUser function. - done

        $check = checkUserExist $name 

        if($check){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "User not found"
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        #check user - done
        if(checkUserExist $name){
            $userLogins = getLogInAndOffs 90
            # TODO: Change the above line in a way that, the days 90 should be taken from the user

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User not found"
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # check user - done
        if(checkUserExist $name){
            $userLogins = getFailedLogins 90
            # TODO: Change the above line in a way that, the days 90 should be taken from the user

            Write-Host ($userLogins | Format-Table | Out-String)
        }
        else{
            Write-Host "User not found"
        }
    }


    # At risk users - WIP 
    #TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option number

    if($choice -eq "9"){
        
        $time = Read-Host -Prompt "How many days back do you want the logs?"
        
        Write-Host "List of users at risk"

        atRiskUser $time
        
    }

    # Fail check - done
    #else{
    #    Write-Host "Unknown selection, please try again"
    #} 


}