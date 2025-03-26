#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f7 | tr -d "[" | sort |  uniq -c)
}

#function ips(){
#ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
#}

getAllLogs
echo "$allLogs"
