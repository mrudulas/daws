#!/bin/bash

# Use ps command to list processes and their CPU usage, then sort them based on CPU usage
# Use head command to display the top 5 processes

PROCESSLIST=$(ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6)
THRESHOLD=0.1

MESSAGE=""

while IFS= read -r process
do
echo $process
USAGE=$(echo $process | awk -F " " '{print $(NF-1)}')
PROCESSNAME=$(echo $process | awk -F " " '{print $3F}')
MESSAGE+="$PROCESSNAME is running with $USAGE, Threshold is $THRESHOLD \n"
done <<< $PROCESSLIST

echo -e "Message is : $MESSAGE"
