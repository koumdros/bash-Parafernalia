#!/bin/bash

## ===== nikoum modular bash framework ==== 0.01 "description"
## this script allows you to  choose between the 3 progressively harsher options in shutting down a non responcive VM

## ===== nikoum modular bash framework ==== 0.11 "colors"
##define colors we will use to make  statements stand out in echo commands
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
NC='\e[0m' # No Color
## use this with echo -e command put the variable e.g. ${red} before the colored string and the no-color variable, ${NC} where you want it to end

## ===== nikoum modular bash framework ==== 0.02 "argument check"
# die if # no of arguments are not provided ( one here)
[ $# -ne 1 ] && {  echo -e "\nUsage: Control_VM.sh ${red}VM_NAME${NC}" && echo -e "you must ${yellow}provide the name ${NC}of the VM you need to control\n" ; exit 1;}

## ===== nikoum modular bash framework ==== 0.03 "preparation"
##

## the folowing comand finds the VM's UUID
VMUU=$(xe vm-list name-label="$*" | awk '/uuid/ {print $5}')
## then we print it to screen
echo -e "\nVM uuid is : ${green}${VMUU}${NC}\n"
## then  we search the domains running on this machine to find which one corresponds to it

VMDOM=$(list_domains | grep "$VMUU" | cut -d' ' -f1) 

## we check  that it actually returned someting if not it means the VM runs in another host

if [ -z "$VMDOM" ]
	then
		echo -e "\nthe VM ${yellow}runs in another Xen-host${NC}, you need to run this script there to get its domain number\n" && echo .
    else
		echo -e "VM domain number is : ${green}${VMDOM}${NC}"
fi


## display the commands so the user can use them at his own time of choosing
echo "==================================="
echo -e "\nCommand to force shutdown VM:\n"

echo "xe vm-shutdown uuid=$VMUU force=true"
echo ".................................."
echo -e "\nCommand to reset Powerstate with the force option\n"

echo "xe vm-reset-powerstate  uuid=$VMUU force=true"
echo ".................................."
echo -e "\nCommand to destroy the VMs domain\n"

echo "/opt/xensource/debug/xenops destroy_domain –domid ${VMDOM}"
echo -e "===================================\n"

## define a function that will present a menu for the user to choose an option 


showMenu () {
	echo "  Server - $(hostname)  "
	echo "-------------------------------"
	echo -e "    ${blue} M A I N - M E N U${NC}"
	echo "-------------------------------"

	echo "1) Force shutdown VM"

	echo "2) Try to reset Powerstate with the force option"

	echo "3) Destroy the VM's Domain"

	echo "4) quit"

}
#showMenu
## wait for 10 seconds for user input
#sleep 15
#exit 0

## ===== nikoum modular bash framework ==== 0.05 "MAIN PART"

# grab the user's responce to the menu above
while [ 2 ]
do
	showMenu
	read CHOICE
	case "$CHOICE" in
		"1")
			xe vm-shutdown "uuid=$VMUU" force=true
			;;
		"2")
			xe vm-reset-powerstate  "uuid=$VMUU" force=true
			;;
		"3")
			/opt/xensource/debug/xenops destroy_domain –domid "$VMDOM"
			;;
		"4")
			exit 0
			## if the user chooses to exit return a success code
			;;
		"*")
#			echo "TEST"
			echo -e "Usage: you must ${yellow}choose a number from 1 to 4 from the options presented to you"
			sleep 5
			exit 1
	esac
	sleep 5
done
