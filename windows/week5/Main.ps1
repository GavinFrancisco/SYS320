.(Join-Path $PSScriptRoot ScrapingClasses.ps1)

clear

$gatCla = gatherClasses
$dev1 = daysTranslator $gatCla


#Deliverable 1
$dev1 | select "Class Code", Instructor, Location, Days, "Start Time", "End Time" | where {$_.Instructor -like "Furkan Paligu"}

#Deliverable 2
$dev1 | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -ccontains "Monday")} | Sort-Object "Start Time" | Select-Object "Start time", "End Time", "Class Code"

#Deliverable 3
$ITInstructors = $dev1 | Where-Object {($_."Class Code" -ilike "SYS*") -or `
                                       ($_."Class Code" -ilike "NET*") -or `
                                       ($_."Class Code" -ilike "SEC*") -or `
                                       ($_."Class Code" -ilike "FOR*") -or `
                                       ($_."Class Code" -ilike "CSI*") -or `
                                       ($_."Class Code" -ilike "DAT*")} `
                       | Sort-Object "Instructor" | Select-Object "Instructor" -Unique

#Deliverable 4
$dev1 | where {$_.Instructor -in $ITInstructors.Instructor} | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending