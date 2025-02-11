clear

function apacheLogFilter(){
    $logsUnFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()
    
    for ($i = 0; $i -lt $logsUnFormatted.count; $i++){
        $words =  $logsUnFormatted[$i].split(" ");

        $tableRecords += [pscustomobject]@{ "IP" = $words[0]; 
                                            "Time" = $words[3].Trim('['); 
                                            "Method" = $words[5].Trim('"');
                                            "Page" = $words[6];
                                            "Protocol" = $words[7].Trim('"');
                                            "Response" = $words[8];
                                            "Referrer" = $words[9];
                                            "Client" = $words[11..($words.count[-1])]}
    }
    
    Return $tableRecords | Where-Object {$_.IP -ilike "10.*"}
}
