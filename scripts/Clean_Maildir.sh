#!/bin/bash
## this script cleans the whole \home directory of a postfix server
#MN=0

usergroup=inactives
cleandays=60
type=new


KINDOFMAIL=${1:-$usergroup} # defaults to inactive users
DAYS=${2:-$cleandays} # Defaults to 60 days
MAILTYPE=${3:-$type} # Defaults to new mail, other option is cur ( meanign current)

echo $KINDOFMAIL
echo $DAYS
echo $MAILTYPE

old_IFS=$IFS #save the field separator

IFS=$'\n'

mailnames=($(cat results/$KINDOFMAIL)) #feed array

MN=${mailnames[@]}

#echo $MN

len=${#mailnames[@]}

echo array size is $len

for i in ${mailnames[@]}; do
	find /home/"$i"/Maildir/$MAILTYPE/ -type f -name "*" -mtime +$DAYS -exec rm {} \;

done

IFS=$old_IFS #restore the old  field separator



#echo $1
#echo '\n'
