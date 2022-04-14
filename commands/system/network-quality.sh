#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Quality
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.author Archie Lacoin & LanikSJ
# @raycast.authorURL https://github.com/pomdtr & https://github.com/LanikSJ

result=$(networkQuality -v)

rtt=$(echo "$result" | grep RTT | awk -F": " '{print $2}')
mbps_down=$(echo "$result" | grep "Download capacity" | awk -F": " '{print $2}')
mbps_up=$(echo "$result" | grep "Upload capacity" | awk -F": " '{print $2}')

echo "↓ ${mbps_down}  ↑ ${mbps_up}  ↔ ${rtt} ms"
