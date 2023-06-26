#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Let Me Google That
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤡
# @raycast.packageName Communication

# Documentation:
# @raycast.description Let Me Google That For You
# @raycast.author Leo Fritsch
# @raycast.authorURL https://github.com/leofritsch

# Get the content of the clipboard
clipboard=$(pbpaste)

# change spaces to plus signs
url_encoded=$(echo "${clipboard}" | sed 's/ /+/g')

# Construct the URL string with the encoded clipboard content
url="https://letmegooglethat.com/?q=${url_encoded}"

# Copy the URL to the clipboard
echo "${url}" | pbcopy
echo -e "Copied to clipboard: ${url}"