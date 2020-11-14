#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Epoch to Human-Readable Date
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName Conversions
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Convert epoch to human-readable date.
# @raycast.author Siyuan Zhang
# @raycast.authorURL https://github.com/kastnerorz

epoch=$(pbpaste)
human=$(echo `date -r $epoch "+%F %T"`)
echo "$human" | pbcopy

echo "Converted $epoch to $human" 
