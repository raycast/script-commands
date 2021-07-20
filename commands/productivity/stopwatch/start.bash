#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Stopwatch
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName time

# Documentation:
# @raycast.description Start a stopwatch
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

if [ -f  timestamp_start.txt ]; then
    echo "A stopwatch already exists!" > /dev/stderr
    exit 1
fi

date +"%s" > timestamp_start.txt
echo "Stopwatch started!"
