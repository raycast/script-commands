#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title External IPv4
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

ip=$(curl -4 -s -m 5 https://ifconfig.co)
echo $ip
