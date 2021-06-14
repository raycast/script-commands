#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Flush DNS
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 💨

# Documentation:
# @raycast.description Flush DNS cache
# @raycast.author Felipe Turcheti
# @raycast.authorURL https://felipeturcheti.com

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
echo "DNS cache flushed"
