#! /bin/bash

logFile=$1

checkerFile=$2

cat $logFile | egrep -i -f $checkerFile | cut -d ' ' -f1,4,7 | tr -d '[' >> report.txt
