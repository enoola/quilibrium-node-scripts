#!/bin/bash

# will add an entry to crontab, for our script to run every xx

SCRIPTTOSCHEDULE_PATH=/root/quilibrium-node-scripts
SCRIPTTOSCHEDULE_FILENAME=qnode_log_revenus.sh

# 1. does an entry refering to this script exists ?
#
bexists=$(crontab -l | grep ${SCRIPTTOSCHEDULE_FILENAME} | wc -c)

if [ $bexists -eq 0; then 
    echo "# m h  dom mon dow   command
    * * * * * ${SCRIPTTOSCHEDULE_PATH}/${SCRIPTTOSCHEDULE_FILENAME}"
elif then
    echo "an entry with ${SCRIPTTOSCHEDULE_FILENAME} already exists, look : "
    crontab -l | grep ${SCRIPTTOSCHEDULE_FILENAME}
fi


