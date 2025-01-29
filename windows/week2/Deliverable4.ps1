clear

if(Get-Process -Name "chrome"){
    Stop-Process -Name "chrome"
}
else{
    Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
}