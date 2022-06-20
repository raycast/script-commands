#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shorten URL with Emojis
# @raycast.mode compact
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🔗

# Documentation:
# @raycast.author Samuel Henry
# @raycast.authorURL https://bne.sh
# @raycast.description Transform the clipboard contents to a short Emoji URL

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboardString=$(pbpaste)

if [[ $pasteboardString =~ $regex ]]
then
	result=$(curl "https://bne.sh/api/shorten?url=$pasteboardString")
    echo $result | ruby -r json -e 'puts JSON.parse(STDIN.read)["url"]' | pbcopy; echo -n `pbpaste`
else
	echo "String in clipboard is a not valid URL"
	exit 1
fi
