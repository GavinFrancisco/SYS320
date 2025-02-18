clear

function gatherClasses() {

    $classes = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.33/Courses.html
    
    $courseData = $classes.ParsedHtml.body.getElementsByTagName("tr")

    $courseList=@()

    for($i=1; $i -lt $courseData.length; $i++){
        
        $tds = $courseData[$i].getElementsByTagName("td")

        $times = $tds[5].innerText.split("-")

        $courseList += [pscustomobject]@{"Class Code" = $tds[0].innerText;
                                         "Title" = $tds[1].innerText;
                                         "Days" = $tds[4].innerText;
                                         "Start Time" = $times[0];
                                         "End Time" = $times[1];
                                         "Instructor" = $tds[6].innerText;
                                         "Location" = $tds[9].innerText;
                                        }

    }

    return $courseList
}

function daysTranslator($FullTable){
    
    for($i=0; $i -lt $FullTable.length; $i++){
        
        $days = @()

        if($FullTable[$i].Days -like "M*"){$Days += "Monday"}

        if($FullTable[$i].Days -like "*T[WF]*"){$Days += "Tuesday"}
        Elseif($FullTable[$i].Days -ilike "T"){$Days += "Tuesday"}

        if($FullTable[$i].Days -like "*W*"){$Days += "Wednesday"}

        if($FullTable[$i].Days -like "*TH*"){$Days += "Thrusday"}

        if($FullTable[$i].Days -like "*F"){$Days += "Friday"}

        $FullTable[$i].Days = $days

    }
    return $FullTable
}