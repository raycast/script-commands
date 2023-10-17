#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Simple Markdown Link Generator
# @raycast.description Quickly and simply generate a markdown formatted link with your specified URL and title.
# @raycast.mode silent
# @raycast.packageName Conversions

# Optional parameters:
# @raycast.icon 🔗
# @raycast.argument1 { "type": "text", "placeholder": "URL" }
# @raycast.argument2 { "type": "text", "placeholder": "Title (default: Link)", "optional": true }

# Description:
# Quickly and simply generate a markdown formatted link with your specified URL and title.
# The generated link is copied to your clipboard for easy pasting.

# Documentation:
# @raycast.author atzzCokeK
# @raycast.authorURL https://github.com/atzzCokeK

URL=$1
TITLE=${2:-Link}  # Use "Link" as default if title is not provided

regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]+'

if [[ $URL =~ $regex ]]; then
    echo "[$TITLE]($URL)" | pbcopy
    echo "Copied: [$TITLE]($URL)"
else
    echo "Invalid URL: $URL"
    exit 1
fi