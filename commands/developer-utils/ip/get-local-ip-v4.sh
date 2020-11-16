#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local IPv4
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Internet

ip=$(ifconfig | grep 'inet.*broadcast' | awk '{print $2}')
IFS=' ' read -ra array <<< "$ip"
echo ${array[0]}
