#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Save URL to Wayback Machine
# @raycast.mode compact

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Save URL to Wayback Machine
# @raycast.icon images/ia-logo.jpg
# @raycast.packageName Internet
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

url=$1
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $url =~ $regex ]]
then 
	curl -s "http://web.archive.org/save/$url" > /dev/null
	echo "Submitted $url to Wayback Machine"
else
	echo "Input is not a valid URL"
fi