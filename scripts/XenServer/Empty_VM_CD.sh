#!/bin/bash
## this script ejects CDs from all the VMs in the Xen pool
## it seems to grab the ones in snapshots as well.
## i believe it has no effect on them
for INSTANCEID in `xe vbd-list type=CD empty=false | egrep uuid | egrep -v 'vm|vdi' | tr -s ' ' | cut -d ' ' -f5`
  do
   xe vbd-eject uuid=${INSTANCEID}
  done
