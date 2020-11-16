#!/bin/bash

# Dependency: emoj (https://github.com/kevva/download-cli)
# Install via npm: `npm install --global download-cli`

# @raycast.schemaVersion 1
# @raycast.title Download URL in clipboard
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Download URL in clipboard.
# @raycast.packageName Developer Utilities
# @raycast.needsConfirmation true
# @raycast.currentDirectoryPath ~/Desktop

if ! command -v download &> /dev/null; then
	echo "download command is required (https://github.com/kevva/download-cli).";
	exit 1;
fi

clipboard=$(pbpaste)
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $clipboard =~ $regex ]]; then 
	download -o ~/Desktop $clipboard
	echo "Downloaded URL to Desktop"
else
	echo "Clipboard is not a valid URL"
	exit 1
fi