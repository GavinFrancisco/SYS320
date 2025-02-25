

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

# checkuser function - Done

function checkUser($name){
   $check = Get-LocalUser -Name $name -ErrorAction SilentlyContinue

   if ($name -eq $check){
        Write-host "User already exists"
   }
   else{
        $checkUser = $true
   }
   return $checkUser
}


# check user exists

function checkUserExist($name){
   $check = Get-LocalUser -Name $name -ErrorAction SilentlyContinue

   if ($name -eq $check){
        $checkUser = $true
   }
   else{
        Write-host "User not found"
   }
   return $checkUser
}

#Password check - done

function checkPassword($password){
   $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
   $dehashPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
   #checks for special character
   if($dehashPassword -match '[^a-zA-Z0-9\s]'){
        $checkPass = $true
   }
   else{
      Write-host "Password needs at least one special character"
      return $checkPass = $false
   }
   #checks for length
   if($dehashPassword.length -ge 6){
        $checkPass = $true
   }
   else{
        Write-host "Password needs at to be at least 6 characters"
        return $checkPass = $false
   }
   #checks for number
   if($dehashPassword -match '[0-9]'){
        $checkPass = $true
   }
   else{
        Write-host "Password must contain a number"
        return $checkPass = $false
   }
   #checks for a letter
   if($dehashPassword -match '[a-zA-Z]'){
        $checkPass = $true
   }
   else{
        Write-host "Password must contain a letter"
        return $checkPass = $false
   }
   return $checkPass
}