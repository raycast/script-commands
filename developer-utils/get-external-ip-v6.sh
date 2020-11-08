#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title External IPv6
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Internet

ip=$(curl -6 -s -m 5 https://ifconfig.co)
echo $ip