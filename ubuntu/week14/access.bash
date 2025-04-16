#! /bin/bash

date=$(date)

echo "File was accessed $date" >> /home/gavin/sys320/SYS320/ubuntu/week14/fileaccesslog.txt

cat /home/gavin/sys320/SYS320/ubuntu/week14/fileaccesslog.txt | tr ':' '-' | ssmtp gavin.francisco@mymail.champlain.edu
