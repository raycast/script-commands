#!/bin/bash

# Dependency: emoj (https://github.com/kevva/download-cli)
# Install via npm: `npm install --global download-cli`

# @raycast.schemaVersion 1
# @raycast.mode silent
# @raycast.title Download URL
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Download URL to Desktop.
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "URL" }
# @raycast.currentDirectoryPath ~/Desktop

if ! command -v download &> /dev/null; then
	echo "download command is required (https://github.com/kevva/download-cli).";
	exit 1;
fi

url=$1
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $url =~ $regex ]]; then 
	download -o ~/Desktop $url
	echo "Downloaded URL to Desktop"
else
	echo "Clipboard is not a valid URL"
	exit 1
fi