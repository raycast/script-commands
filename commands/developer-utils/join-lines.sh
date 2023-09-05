#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Join Clipboard Lines by Delimiter
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🛠
# @raycast.argument1 { "type": "text", "placeholder": "delimiter", "optional": true }
# @raycast.packageName Developer Utilities

# Documentation:
# @raycast.description Join multiple lines of text from the clipboard into a single line, separated by a specified delimiter.
# @raycast.author decaylala
# @raycast.authorURL https://github.com/decaylala

pbpaste | awk -v d="$1" 'BEGIN {ORS=d} {print}' | awk -v d="$1" 'sub(d "$", "")' | pbcopy
echo 'Copied to clipboard'
