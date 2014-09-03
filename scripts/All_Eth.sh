#!/bin/bash
## ===== nikoum modular bash framework ==== 0.01 "description"
# list IPs of ALL ethernet nics
# if "IF" is provided as the argument list the interface as well
# if "table" is provided as the argument a nicely formated table is the output that also list the MAC addresses and interface as well
# if "simple" is provied the IPs are the only thing returned ( no fluff). This is so it can be used when called from another script


## ===== nikoum modular bash framework ==== 0.03 "preparation"
## we give the wantif variable a default value of IF
## if however an argument is provided then it replaces the default value

wantIF=$1
: ${wantIF:=IF}

# this is for debuging purposes
# echo argument provided : $wantIF

## ===== nikoum modular bash framework ==== 0.05 "MAIN PART"
## use a case structure to parse arguments 


case "$wantIF" in
        no)
			echo -e "+++++++++++++++++\n"
			ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'
			echo -e "\n+++++++++++++++++"
            		;;
		simple)
			ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'
					;;
        IF)
			echo -e "+++++++++++++++++++++++\n"
			ifconfig  | grep -B 1 'inet addr:' | egrep -v "\\--" | sed 'N;s/\n/ /' | egrep -v '127.0.0.1' | tr -s ' ' | cut -d: -f 1,9 | cut -d' ' -f1,3 | sed -e s/encap://
			echo -e "\n+++++++++++++++++++++++"
					;;
        table)
            echo -e "++++++++++++++++++++++++++++++++++++++++++\n"
			(echo "DEVICE MAC-ADDRESS IP-ADDRESS" && ifconfig  | grep --no-group-separator 'inet addr:' -B 1 | sed 'N;s/\n/ /' | egrep -v Loopback | tr -s ' ' | cut -d' ' -f1,5,7 | sed 's/addr\://g') | column -t
            echo -e "\n++++++++++++++++++++++++++++++++++++++++++"
					;;
		*)
			echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++\n"
            	echo "Usage: All_Eth.sh {no argument|IF|no|table|simple}"
			echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++\n"
            exit 1
esac
