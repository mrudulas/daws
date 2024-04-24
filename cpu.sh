#!/bin/bash

# Use ps command to list processes and their CPU usage, then sort them based on CPU usage
# Use head command to display the top 5 processes

ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6
