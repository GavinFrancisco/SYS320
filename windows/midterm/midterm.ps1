clear

function gatherWebInfo(){
    
    $webShell = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.6/IOC.html

    $info = $webShell.ParsedHtml.body.getElementsByTagName("tr") 

    $list = @()

    for($i=1; $i -lt $info.length;$i++){
        
        $tds = $info[$i].getElementsByTagName("td")

        if($i -ne 0){

            $list += [pscustomobject]@{"Pattern" = $tds[0].innerText; 
                                       "Explaination" = $tds[1].innerText}
        }

    }

    return $list
}

function apacheLogs(){
    
    $logs = Get-Content C:\Users\champuser\SYS320\windows\access.log
    $logsFormatted = @()

    for($i = 0; $i -lt $logs.count; $i++){
        $words = $logs[$i].split(" ");

        $logsFormatted += [pscustomobject]@{"IP" = $words[0];
                                            "Time" = $words[3].Trim('[');
                                            "Method" = $words[5].Trim('"')
                                            "Page" = $words[6];
                                            "Protocol" = $words[7].Trim('"');
                                            "Response" = $words[8];
                                            "Referrer" = $words[9]
                                            }
    }
    Return $logsFormatted
}

function filterLogs($logs, $filter){

    $test = $filter | Select-Object "Pattern"
    $filteredLogs = @()
    #Takes in logs one by one and passes them through the loop
    for($j = 0; $j -lt $logs.Length; $j++){
        $checkingLogs = $logs[$j].Page
        #Takings in filters and applies each filter to 
        for($i = 0; $i -lt $filter.Length; $i++){
            $checkingFilter = $test.Pattern[$i]
            $testing = $checkingLogs | Select-String $checkingFilter
            if($testing){
                $filteredLogs += [pscustomobject]@{"IP" = $logs.IP[$j];
                                                   "Time" = $logs.Time[$j];
                                                   "Method" = $logs.Method[$j];
                                                   "Page" = $logs.Page[$j];
                                                   "Protocol" = $logs.Protocol[$j];
                                                   "Response" = $logs.Response[$j];
                                                   "Referrer" = $logs.Referrer[$j]}
            }
        }
    }
    return $filteredLogs | Sort-Object -Property Page -Unique
}

$logs = apachelogs
$filter = gatherWebInfo
$Final = filterLogs $logs $filter
$Final | Format-Table -AutoSize -Wrap