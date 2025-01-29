clear

$loginouts = Get-Eventlog system -source Microsoft-Windows-Winlogon -After (Get-Date).Adddays(-14)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.count; $i++){
    #Creating Event value
    $event = ""
    if($loginouts[$i].instanceID -eq 7001){
        $event = "logon"
    }
    if($loginouts[$i].instanceID -eq 7002){
        $event = "logoff"
    }
    
    #Creating User value
    $SID = $loginouts[$i].ReplacementStrings[1]
    $test = New-Object System.Security.Principal.SecurityIdentifier($SID)
    $user = $test.Translate([System.Security.Principal.NTAccount])
    
    #Setting values in the table
    $loginoutsTable += [pscustomobject]@{ "Time" = $loginouts[$i].TimeGenerated
                                            "Id" = $loginouts[$i].EventID
                                         "Event" = $event;
                                          "User" = $user;
                                        }
}
$loginoutsTable