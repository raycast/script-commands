#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Human-Readable Date To Epoch
# @raycast.mode silent
# @raycast.packageName Conversions
#
# Optional parameters:
# @raycast.icon ⏱
# @raycast.needsConfirmation false
# @raycast.argument1 {"type": "text", "placeholder": "Date"}
#
# Documentation:
# @raycast.description Convert human-readable date to timestamp epoch.
# @raycast.author Siyuan Zhang
# @raycast.authorURL https://github.com/kastnerorz

date=${1}
epoch=$(echo `date -jRuf "%F %T" "$date" "+%s"`)
echo -n "$epoch" | pbcopy

echo "Converted $date to $epoch" 
