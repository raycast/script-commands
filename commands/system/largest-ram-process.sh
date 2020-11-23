#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Largest RAM Process
# @raycast.mode inline
# @raycast.refreshTime 1m
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Report process with largest system RAM usage.
# @raycast.packageName System
# @raycast.icon 📈

output=$(ps -exco rss,comm | sort -k 1 -n -r | head -n 1)
kbytes=$(echo "$output" | awk -F " " '{ st = index($0," ");print $1}')
cmd=$(echo "$output" | awk -F " " '{ st = index($0," ");print substr($0,st+1)}')


## Kilobytes
print_as_kb=$(echo "$kbytes < 1024" | bc -l)

if (( print_as_kb )); then
	echo "${cmd} - ${kbytes} KB"
	exit 0
fi


## Megabytes
mbytes=$(echo "scale=3; $kbytes / 1024" | bc -l)
print_as_mb=$(echo "$mbytes < 1024" | bc -l)

if (( print_as_mb )); then
	echo "${cmd} - ${mbytes} MB"
	exit 0
fi


## Gigabytes
gbytes=$( echo "scale=3; $mbytes / 1024" | bc -l)
echo "${cmd} - ${gbytes} GB"