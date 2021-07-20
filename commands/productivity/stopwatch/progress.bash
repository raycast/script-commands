#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Stopwatch Progress
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName time

# Documentation:
# @raycast.description Status of active stopwatch
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

if [ ! -f  timestamp_start.txt ]; then
    echo "No stopwatch currently exist!" > /dev/stderr
    exit 1
fi

NOW=$(date +"%s")
START=$(<timestamp_start.txt)
DIFF=$((NOW - START))

if [ $DIFF -lt 60 ]; then
    printf '%02ds' $((DIFF%60))
elif [ $DIFF -lt 3600 ]; then
    printf '%02dm:%02ds' $((DIFF%3600/60)) $((DIFF%60))
else
    printf '%02dh:%02dm:%02ds' $((DIFF/3600)) $((DIFF%3600/60)) $((DIFF%60))
fi
