#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local IPv4
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the local IPv4 to the clipboard.

ip=$(ifconfig | grep 'inet.*broadcast' | awk '{print $2}')
IFS=' ' read -ra array <<< "$ip"
echo ${array[0]} | tr -d '\n' | pbcopy
echo "Copied $ip"
