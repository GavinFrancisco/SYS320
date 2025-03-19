#!/bin/bash

[ $# -ne 1 ] && echo "Usage $0 <Prefix>" && exit 1

prefix=$1

[ ${#prefix} -lt 5 ] && printf "Prefix Length is to short\n" && exit 1

for i in {1..254};
do
	ping -c 1 "$prefix.$i" | grep "64 bytes" | cut -d " " -f 4
done
