#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Quality
# @raycast.mode inline
# @raycast.refreshTime 20m

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.packageName System
# @raycast.author Archie Lacoin
# @raycast.authorURL https://github.com/pomdtr
# @raycast.author LanikSJ
# @raycast.authorURL https://github.com/LanikSJ

result=$(networkQuality -v)

rtt=$(echo "$result" | grep RTT | awk -F": " '{print $2}')
mbps_down=$(echo "$result" | grep "Download capacity" | awk -F": " '{print $2}')
mbps_up=$(echo "$result" | grep "Upload capacity" | awk -F": " '{print $2}')

echo "↓ ${mbps_down}  ↑ ${mbps_up}  ↔ ${rtt} ms"
