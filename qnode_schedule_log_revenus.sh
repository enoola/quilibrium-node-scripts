#!/bin/bash

# will add an entry to crontab, for our script to run every xx

SCRIPTTOSCHEDULE_PATH=/root/quilibrium-node-scripts
SCRIPTTOSCHEDULE_FILENAME=qnode_log_revenus.sh

# 1. does an entry refering to this script exists ?
#* * * * * cd /root/ceremonyclient/node && ./node-1.4.19-linux-amd64 -node-info | /root/quilibrium-node-scripts/qnode_log_revenus.sh /root/qnode_$(hostname)_revenus.csv

JOB_TO_SCHEDULE=cd /root/ceremonyclient/node && ./node-1.4.19-linux-amd64 -node-info | /${SCRIPTTOSCHEDULE_PATH}/qnode_log_revenus.sh /root/$(hostname)_revenus.csv

bexists=$(crontab -l | grep ${SCRIPTTOSCHEDULE_FILENAME} | wc -c)

if [ $bexists -eq 0; then 
    echo "# m h  dom mon dow command
    * * * * * ${JOB_TO_SCHEDULE}"
elif then
    echo "an entry with ${SCRIPTTOSCHEDULE_FILENAME} already exists, look : "
    crontab -l | grep ${SCRIPTTOSCHEDULE_FILENAME}
fi


