#!/bin/bash

## #
# 20240611 @PhPteur
# this script aims to backup your node to a remote server
##

## hostname or ip
DESTINATION_HOSTNAME=$(cat /root/conf_hostname.conf)
DESTINATION_USERNAME=$(cat /root/conf_username.conf)

## /!\ we rely on the machine it runs on' hostname to know where to put the file,
## and also for the archive naming later on
DESTINATION_PATH=/data/${DESTINATION_USERNAME}/QuilNodes/${HOSTNAME}/


##stop the service
service ceremonyclient stop

## Now we'll loop, and see if it is really gone
i=0
while [ $(ps -C "node-1.4.19-lin" | wc -l ) -gt 1 ];do 
	((i++)); 
	sleep 1;
	echo -n .;
	if [ "$i" -gt 5 ]; then 
		pkill node && pkill -f "go run ./...";
		fi ;
done
# here we know the node daemon ceremony is stopped
echo "qnode stopped"

# let's make backup name unique
# first gather current date, it will be our file prefix
prefixdate=$(date +"%Y%m%d_%H%M")

# create the archive: 
tar -cvzf ${prefixdate}_qnode_${HOSTNAME}_KandStore.tar.gz qnode-${HOSTNAME}_revenus.csv qnode_log_revenus.sh ~/ceremonyclient/node/.config

QUILERS_RSAKEY_PATH="/root/.ssh/"
QUILERS_RSAKEY_NAME="id_rsa_qnode"
# send it to our remote server
# via rsync wrapped in an SSH session
if [[ ! -f "${QUILERS_RSAKEY_PATH}/${QUILERS_RSAKEY_NAME}" ]]; then
	echo "File not found: ${QUILERS_RSAKEY_PATH}/${QUILERS_RSAKEY_NAME}"
fi

#rsync -e "ssh -i ~/.ssh/id_ed25519" --progress --checksum --verbose ${prefixdate}_qnode_${HOSTNAME}_KandStore.tar.gz enola@${DESTINATION_HOSTNAME}:${DESTINATION_PATH}
rsync -e "ssh -i ~/.ssh/id_rsa_qnode" --progress --checksum --verbose ${prefixdate}_qnode_${HOSTNAME}_KandStore.tar.gz enola@${DESTINATION_HOSTNAME}:${DESTINATION_PATH}

# now we can start the node backup
service ceremonyclient start

# here we should do some cleaning
