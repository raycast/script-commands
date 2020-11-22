#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Largest RAM Process
# @raycast.mode inline
# @raycast.refreshTime 1m
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Report process with greatest system RAM usage.
# @raycast.packageName System
# @raycast.icon 📈

output=$(ps -exco rss,comm | sort -k 1 -n -r | head -n 1)
bytes=$(echo "$output" | awk -F " " '{ st = index($0," ");print $1}')
cmd=$(echo "$output" | awk -F " " '{ st = index($0," ");print substr($0,st+1)}')

gigabytes=$(echo "scale=3; $bytes / 1024 / 1024" | bc -l)

echo "${cmd} - ${gigabytes}GB"