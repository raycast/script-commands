#!/bin/bash

# Dependency: requires pageres (https://github.com/sindresorhus/pageres-cli)
# Install via npm: `npm install --global pageres-cli`

# Set viewport resolution of screenshots
resolutions="1920x1080 390x844"

# @raycast.schemaVersion 1
# @raycast.title Screenshot Website from Clipboard
# @raycast.mode compact
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Takes a screenshot of the Website from your Clipboard and saves it to the Desktop.
# @raycast.packageName Internet
# @raycast.currentDirectoryPath ~/Desktop
# @raycast.icon 🖼️

if ! command -v pageres &> /dev/null; then
	echo "pageres command is required (https://github.com/sindresorhus/pageres-cli).";
	exit 1;
fi

if [ -z ${resolutions+x} ]; then
	echo "Viewport resolutions are undefined.";
	exit 0
fi

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
clipboard=$(pbpaste)

if [[ $clipboard =~ $regex ]]; then 
	output=$(pageres --crop "$clipboard" $resolutions)
	echo "Saved screenshot(s) to Desktop"
else
	echo "Clipboard does not contain a valid url"
fi