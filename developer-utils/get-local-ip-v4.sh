#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Local IPv4
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Internet

ip=$(ifconfig | grep 'inet.*broadcast' | awk '{print $2}')
echo $ip | pbcopy

echo "Copied $ip"
