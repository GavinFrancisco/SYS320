#! bin/bash

website="10.0.17.6/Assignment.html"

firstTable=$(curl $website | htmlq --text 'table:nth-of-type(1)' | awk 'NF')
secondTable=$(curl $website | htmlq --text 'table:nth-of-type(2)' | awk 'NF')

table1Done=()
table2Done=()

while IFS= read -r line;
do
	table1Done+=("$line")
done <<< "$firstTable"

while IFS= read -r line;
do
	table2Done+=("$line")
done <<< "$secondTable"

for ((i=2; i < ${#table1Done[@]}-1; i+=2));
do
	echo "${table1Done[$i]}${table2Done[$i]}${table1Done[$i+1]}"
done
