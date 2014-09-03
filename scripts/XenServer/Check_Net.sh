#!/bin/bash
for PIFUUID in `xe pif-list | awk '/uuid/ {print $5}'| sed '/^$/d'`
  do
    xe pif-param-list uuid=$PIFUUID | grep  "other-config"
done
