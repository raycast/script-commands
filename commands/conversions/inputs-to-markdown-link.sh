#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Simple Markdown Link Generator
# @raycast.mode silent
# @raycast.packageName Conversions

# Optional parameters:
# @raycast.icon 🔗
# @raycast.argument1 { "type": "text", "placeholder": "Title" }
# @raycast.argument2 { "type": "text", "placeholder": "URL" }

# Description:
# Quickly and simply generate a markdown formatted link with your specified title and URL.
# The generated link is copied to your clipboard for easy pasting.

# Documentation:
# @raycast.author atzzCokeK
# @raycast.authorURL https://github.com/atzzCokeK

regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]+'

if [[ $2 =~ $regex ]]; then
    echo "[$1]($2)" | pbcopy
    echo "Copied: [$1]($2)"
else
    echo "Invalid URL: $2"
    exit 1
fi