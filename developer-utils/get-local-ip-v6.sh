#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local IPv6
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Internet

ip=$(ifconfig | grep 'inet6.*%en' | awk '{print $2}')
echo $ip | pbcopy

echo "Copied $ip"
