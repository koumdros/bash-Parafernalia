#!/bin/bash

##this script prints a sorted list of the VMs in the xenServer pool
##
## if it is run with argument UUID 
##
## it also prints the UUIDs of said VMS
########
## it does NOT print the control domains or their UUIDS by default

noU=no
wantU=${1:-$noU} # defaults to no

# this is for debuging purposes
# echo argument provided :  $wantU

case "$wantU" in
        no)
			echo +++++++++++++++++++++++++++++++++++++
			echo .
			xe vm-list | awk '/name-label/' | grep -v "Control domain" | awk '{print $4}' | sort -n
			echo .
			echo +++++++++++++++++++++++++++++++++++++
            		;;
        UUID)
			echo +++++++++++++++++++++++++++++++++++++
			echo .
			xe vm-list | awk '/name-label|uuid/' | sed 'N;s/\n/ /' | grep -v 'Control domain' | tr -s ' ' | cut -d' ' -f5,9-14 | sort -k 2
			echo .
			echo +++++++++++++++++++++++++++++++++++++
                        ;;
	*)
			echo +++++++++++++++++++++++++++++++++++++
			echo .
                	echo "Usage: List_VMs.sh {no argument|UUID}"
                        echo .
			echo +++++++++++++++++++++++++++++++++++++
	                exit  1
esac


#place holder comand to integrate in the future:
# grabs UUId and name of host members
#
#  xe host-list | awk '/name-label|uuid/' | sed 'N;s/\n/ /' | tr -s ' ' | cut -d' ' -f 5,9 | sort -k 2
#
