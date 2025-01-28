clear

cd $PSScriptRoot

$file=(Get-ChildItem)
for ($j=0; $j -le $files.Exists; $j++){
    if($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}