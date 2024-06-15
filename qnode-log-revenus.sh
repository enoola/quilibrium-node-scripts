#!/bin/bash

#20240609 PhPeteur

##
#log revenus which is provided by running :  standard output.
#(crontab -l 2>/dev/null; echo "*/5 * * * * $SCRIPT_PATH") | crontab -
#
## The below run every hours
#42 * * * * cd /root/ceremonyclient/node && ./node-1.4.19-linux-amd64 -node-info | /root/qnode-log-revenus.sh /root/qnode-${HOSTNAME}_revenus.csv

# Check if the output file argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <output_file>"
  exit 1
fi

output_file=$1

# Read standard input into a variable
output=$(cat)

# Get the current date and time
current_time=$(date +"%Y%m%d %H:%M:%S")

# Extract the values
peer_id=$(echo "$output" | grep "Peer ID:" | awk -F": " '{print $2}')
version=$(echo "$output" | grep "Version:" | awk -F": " '{print $2}')
max_frame=$(echo "$output" | grep "Max Frame:" | awk -F": " '{print $2}')
peer_score=$(echo "$output" | grep "Peer Score:" | awk -F": " '{print $2}')
unclaimed_balance=$(echo "$output" | grep "Unclaimed balance:" | awk -F": " '{print $2}')

# Line number (here it's the first line, so 1)
line_number=1

# Create a CSV line
csv_line="$line_number,$peer_id,$current_time,$version,$max_frame,$peer_score,$unclaimed_balance"

# Check if the file exists
if [ ! -f "$output_file" ]; then
  # File doesn't exist, create it with header
  echo "Line Number,Peer ID,Date,Version,Max Frame,Peer Score,Unclaimed Balance" > "$output_file"
fi

#echo $csv_line
# Append the CSV line to the file
echo "$csv_line" >> "$output_file"

exit 0
#echo "CSV line generated successfully and saved to $output_file."
