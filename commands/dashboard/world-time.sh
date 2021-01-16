#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title World Time
# @raycast.mode inline
# @raycast.refreshTime 5s
# @raycast.packageName Dashboard

# Optional parameters:
# @raycast.icon 🕐
#
# Documentation:
# @raycast.description Show the time from elsewhere in the world
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

# Timezones can be found in /usr/share/zoneinfo

nyc=$(TZ=America/New_York date +"%H:%I")
lon=$(TZ=Europe/London date +"%H:%I")
bne=$(TZ=Australia/Brisbane date +"%H:%I")

echo "New York City: $nyc | London: $lon | Brisbane: $bne"
