#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Epoch to Human-Readable Date
# @raycast.mode silent
# @raycast.packageName Conversions
#
# Optional parameters:
# @raycast.icon ⏱
# @raycast.needsConfirmation false
# @raycast.argument1 {"type": "text", "placeholder": "Timestamp Epoch"}
#
# Documentation:
# @raycast.description Convert epoch to human-readable date.
# @raycast.author Siyuan Zhang
# @raycast.authorURL https://github.com/kastnerorz

epoch=${1}
human=$(echo `date -r $epoch "+%F %T"`)
echo -n "$human" | pbcopy

echo "Converted $epoch to $human" 
