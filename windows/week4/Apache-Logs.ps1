clear

function apache-logs ($page, $httpCode, $webBrowser){
    cd C:\xampp\apache\logs
    $logSearch = Get-Content access.log | Select-String $page | Select-String $httpCode
    $notfound = $logSearch | Select-String $webBrowser

    #Define a regex for IP addresses
    $regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

    # Get $notfounds records that match to the regex
    $ipsUnorganized = $regex.match($notfound)

    # Get ips as pscustomobject
    $ips = @()
    for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
        $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].value;}
    }
    $ipoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
    $counts = $ipoftens | Group
    $counts | Select-Object Count, name
}