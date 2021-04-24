#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shorten URL From Clipboard
# @raycast.mode silent
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🔗

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Shorten the URL in your Clipboard with Tiny URL.

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
pasteboardString=$(pbpaste)

if [[ $pasteboardString =~ $regex ]] 
then 
	result=$(curl "https://tinyurl.com/api-create.php?url=$pasteboardString")
	if [[ $result != "Error" ]]
	then
		echo $result | pbcopy
		echo "Copied shortened URL"
	else 
		echo "URL cannot be shortened"
		exit 1
	fi
else
	echo "String in clipboard is a not valid URL"
	exit 1
fi
