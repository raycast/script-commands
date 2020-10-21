#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open URL From Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboardString=$(pbpaste)

if [[ $pasteboardString =~ $regex ]]
then 
    open $pasteboardString
else
    echo "String in clipboard is a not valid URL"
fi

