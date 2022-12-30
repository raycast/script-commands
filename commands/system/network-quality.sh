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

rtt=$(echo "$result" | grep "Idle Latency" | awk '{print $3}')
mbps_down=$(echo "$result" | grep "Downlink capacity" | awk '{print $3 tolower($4)}')
mbps_up=$(echo "$result" | grep "Uplink capacity" | awk '{print $3 tolower($4)}')

echo "↓ ${mbps_down}  ↑ ${mbps_up}  ↔ ${rtt} ms"
