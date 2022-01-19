#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local IPv6
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the local IPv6 to the clipboard.

ip=$(ifconfig | grep 'inet6.*%en' | awk '{print $2}')
IFS=' ' read -ra array <<< "$ip"
echo ${array[0]} | tr -d '\n' | pbcopy
echo "Copied $ip"
