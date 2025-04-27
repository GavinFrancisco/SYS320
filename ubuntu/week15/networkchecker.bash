#!/bin/bash

myIP=$(bash IP_Address.bash)


# Todo-1: Create a helpmenu function that prints help for the script
function helpmenu(){
echo "      Help Menu"
echo  "------------------------------"
echo "-n: Add -n as an argument for this script to use nmap"
echo " -n external: External NMAP scan"
echo " -n internal: Internal NMAP scan"
echo "-s: Add -s as an argument for this script to use ss"
echo " -s external: Enternal ss(Netstat) scan"
echo " -s internal: Internal ss(Netstat) scan"
echo "------------------------------"
echo "Example: bash networkchecker.bash -n/-s external/internal"
echo "------------------------------"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo $rex
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo $rin
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){

# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
  ELP=$(ss -ltpn dst "${myIP}" | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
  echo $ELP
}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
  ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
  echo $ilpo
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

first=$1
second=$2

if [ ${#} -eq 2 ]; then
	while getopts ":n:s:" option
	do
		case $option in
		n)
			if [ "${OPTARG}" == "external" ]; then
				ExternalNmap

			elif [ "${OPTARG}" == "internal" ];then
				InternalNmap

			else
				echo "invalid input"
				helpmenu
			fi
		;;
		s)
			 if [ "${OPTARG}" == "external" ]; then
                                 ExternalListeningPorts

                         elif [ "${OPTARG}" == "internal" ];then
                                 InternalListeningPorts

                         else
                                 echo "invalid input"
                                 helpmenu
                         fi

		;;
		?)
			echo "Invalid input type"
			helpmenu
		esac
	done
else
	echo "Invalid amount of inputs"
	helpmenu
fi

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)


