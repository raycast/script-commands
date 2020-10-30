#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wayback Machine - Save clipboard URL
# @raycast.mode compact

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Save URL in clipboard to Wayback Machine
# @raycast.icon images/ia-logo.jpg

url=$(pbpaste)
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $url =~ $regex ]]
then 
	curl -s "http://web.archive.org/save/$url" > /dev/null
	echo "Submitted $url to Wayback Machine"
else
	echo "$url (in clipboard) is not valid URL"
fi