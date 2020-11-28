#!/bin/bash

# @raycast.title Largest RAM Process
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Report process with largest system RAM usage.

# @raycast.icon 📈
# @raycast.mode inline
# @raycast.packageName System
# @raycast.refreshTime 3m
# @raycast.schemaVersion 1

output=$(ps -exco rss,comm | sort -k 1 -n -r | head -n 1)
kbytes=$(echo "$output" | awk -F " " '{ st = index($0," ");print $1}')
cmd=$(echo "$output" | awk -F " " '{ st = index($0," ");print substr($0,st+1)}')


## Kilobytes (no decimal places)
print_as_kb=$(echo "$kbytes < 1024" | bc -l)

if (( print_as_kb )); then
	echo "${cmd} - ${kbytes} KB"
	exit 0
fi


## Megabytes (one decimal place)
mbytes=$(echo "scale=1; $kbytes / 1024" | bc -l)
print_as_mb=$(echo "$mbytes < 1024" | bc -l)

if (( print_as_mb )); then
	echo "${cmd} - ${mbytes} MB"
	exit 0
fi


## Gigabytes (two decimal places)
gbytes=$( echo "scale=2; $kbytes / 1024 / 1024" | bc -l)
echo "${cmd} - ${gbytes} GB"