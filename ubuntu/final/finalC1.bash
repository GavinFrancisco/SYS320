#! /bin/bash

website="10.0.17.6/IOC.html"

IOC=$(curl $website | htmlq --text 'table:nth-of-type(1)' | awk "NF" | tr -d ' ')

IOCtable=()

while IFS= read -r line;
do
	IOCtable+=("$line")
done <<< "$IOC"

for ((i=2; i < ${#IOCtable[@]}; i+=2 ));
do
	echo "${IOCtable[$i]}" >> test.txt
done

tr -d '\t' < test.txt > IOC.txt
rm test.txt
