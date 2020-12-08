#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open URL From Clipboard
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Opens the URL in the clipboard.

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboardString=$(pbpaste)

if [[ $pasteboardString =~ $regex ]]
then 
    open $pasteboardString
else
    echo "String in clipboard is a not valid URL"
fi

