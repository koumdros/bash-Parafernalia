#!/bin/bash
#checks the status of the offloading settings of NICs in XenServer
for INSTANCEID in`xe vm-list | awk '/name-label/' | grep -v "Control domain" | awk '{print $4}'`
  do
    VMUUID=`xe vm-list name-label=${INSTANCEID} | awk '/uuid/ {print $5}'`
      for VIFUUID in`xe vif-list vm-uuid=$VMUUID | awk '/uuid/ {print $5}' | sed '/^$/d'`
        do
  	  xe pif-param-list uuid=$VIFUUID | grep "other-config"
     	done
  done
