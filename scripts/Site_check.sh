#!/bin/bash

## ===== nikoum modular bash framework ==== 0.11 "colors"
##define colors we will use to make  statements stand out in echo commands
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
magenta='\e[0;35m'
cyan='\e[0;36m'
lightgray='\e[0;37m'
#-------------
darkgray='\e[0;90m'
lightred='\e[0;91m'
lightgreen='\e[0;92m'
lightyellow='\e[0;93m'
lightblue='\e[0;94m'
lightmagenta='\e[0;95m'
lightcyan='\e[0;96m'
NC='\e[0m' # No Color
## use this with echo -e command put the variable e.g. ${red} before the colored string and the no-color variable, ${NC} where you want it to end



function check {
	if [ $? -ne 0 ] ; then
			echo "Error occurred getting URL $1:"
				if [ $? -eq 6 ]; then
					echo "Unable to resolve host"
				fi
				if [ $? -eq 7 ]; then
					echo "Unable to connect to host"
				fi
				exit 1
			else 
				echo "$@ appears to  be up"
     fi
}


echo -e "-------------------------------"
echo -e "   ${lightgray} CONNECTIVITY REPORT${NC}"
echo -e " for Server - $1  "
echo -e "-------------------------------"

curl -s -o "/dev/null" $1
check;
echo -e "-------------------------------"

## call curl again to get the http code this time

## http_stat=$(curl -sS -o "/dev/null" -I -w "\n${yellow}\n%{http_code}${NC}\n\n" $1)
http_stat=$(curl -sS -o "/dev/null" -I -w "%{http_code}" $1)

echo -e "\nthe HTTP status code returned is ${cyan}$http_stat${NC}\n\n"

##  get the STATUS (from code) which is human interpretable:

case $http_stat in

	000) echo -e "Not responding within $timeout seconds" ;;
	100) echo -e "Informational: Continue" ;;
	101) echo -e "Informational: Switching Protocols" ;;
	200) echo -e "${green}Successful${NC}: OK within $timeout seconds" ;;
	201) echo -e "${green}Successful${NC}: Created" ;;
	202) echo -e "${green}Successful${NC}: Accepted" ;;
	203) echo -e "${green}Successful${NC}: Non-Authoritative Information" ;;
	204) echo -e "${green}Successful${NC}: No Content" ;;
	205) echo -e "${green}Successful${NC}: Reset Content" ;;
	206) echo -e "${green}Successful${NC}: Partial Content" ;;
	300) echo -e "${lightblue}Redirection{${NC}: Multiple Choices" ;;
	301) echo -e "${lightblue}Redirection{${NC}: Moved Permanently" ;;
	302) echo -e "${lightblue}Redirection{${NC}: Found residing temporarily under different URI" ;;
	303) echo -e "${lightblue}Redirection{${NC}: See Other" ;;
	304) echo -e "${lightblue}Redirection{${NC}: Not Modified" ;;
	305) echo -e "${lightblue}Redirection{${NC}: Use Proxy" ;;
	306) echo -e "${lightblue}Redirection{${NC}: status not defined" ;;
	307) echo -e "${lightblue}Redirection{${NC}: Temporary Redirect" ;;
	400) echo -e "${lightred}Client Error${NC}: Bad Request" ;;
	401) echo -e "${lightred}Client Error${NC}: Unauthorized" ;;
	402) echo -e "${lightred}Client Error${NC}: Payment Required" ;;
	403) echo -e "${lightred}Client Error${NC}: Forbidden" ;;
	404) echo -e "${lightred}Client Error${NC}: Not Found" ;;
	405) echo -e "${lightred}Client Error${NC}: Method Not Allowed" ;;
	406) echo -e "${lightred}Client Error${NC}: Not Acceptable" ;;
	407) echo -e "${lightred}Client Error${NC}: Proxy Authentication Required" ;;
	408) echo -e "${lightred}Client Error${NC}: Request Timeout within $timeout seconds" ;;
	409) echo -e "${lightred}Client Error${NC}: Conflict" ;;
	410) echo -e "${lightred}Client Error${NC}: Gone" ;;
	411) echo -e "${lightred}Client Error${NC}: Length Required" ;;
	412) echo -e "${lightred}Client Error${NC}: Precondition Failed" ;;
	413) echo -e "${lightred}Client Error${NC}: Request Entity Too Large" ;;
	414) echo -e "${lightred}Client Error${NC}: Request-URI Too Long" ;;
	415) echo -e "${lightred}Client Error${NC}: Unsupported Media Type" ;;
	416) echo -e "${lightred}Client Error${NC}: Requested Range Not Satisfiable" ;;
	417) echo -e "${lightred}Client Error${NC}: Expectation Failed" ;;
	500) echo -e "${red}Server Error${NC}: Internal Server Error" ;;
	501) echo -e "${red}Server Error${NC}: Not Implemented" ;;
	502) echo -e "${red}Server Error${NC}: Bad Gateway" ;;
	503) echo -e "${red}Server Error${NC}: Service Unavailable" ;;
	504) echo -e "${red}Server Error${NC}: Gateway Timeout within $timeout seconds" ;;
	505) echo -e "${red}Server Error${NC}: HTTP Version Not Supported" ;;
	*) echo " !! httpstatus: status not defined." && exit 1 ;;
esac

echo -e "\n\n"

#eof
