clear

cd C:\xampp\apache\logs

#Get only logs that contain 404, save into $notfounds
$notfounds = Get-content access.log | Select-String '404'

$notfounds

#Define a regex for IP addresses
$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.match($notfounds)

# Get ips as pscustomobject
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].value;}
}
$ipoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipoftens | Group
$counts | Select-Object Count, name