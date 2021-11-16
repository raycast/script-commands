#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shorten URL from GitHub
# @raycast.mode silent
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon images/git-io.png

# Documentation:
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit
# @raycast.description Shorten any github.com URL

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]?(github)\.(com|io)'
getLink=$(pbpaste)

if [[ $getLink =~ $regex ]]
then
	result=$(curl -i https://git.io -F "url=$getLink" | grep Location)
	location="Location: "
	resultCleanup=${result//$location/}

	if [[ $result != "Error" ]]
	then
		echo $resultCleanup | pbcopy
		echo "Copied URL: $resultCleanup"
	else
		echo "URL cannot be shortened"
		exit 1
	fi
else
	echo "String in clipboard is not a valid URL"
	exit 1
fi
