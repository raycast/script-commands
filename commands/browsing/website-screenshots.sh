#!/bin/bash

# Dependency: requires pageres (https://github.com/sindresorhus/pageres-cli)
# Install via npm: `npm install --global pageres-cli`

# Set viewport resolution of screenshots
resolutions="1920x1080 390x844"

# @raycast.title Screenshot Website
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Takes screenshots of the entered URL using [`pageres`](https://github.com/sindresorhus/pageres) and saves it to the Desktop.

# @raycast.currentDirectoryPath ~/Desktop
# @raycast.icon 🖼️
# @raycast.mode compact
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if ! command -v pageres &> /dev/null; then
	echo "pageres command is required (https://github.com/sindresorhus/pageres-cli).";
	exit 1;
fi

if [ -z ${resolutions+x} ]; then
	echo "Viewport resolutions are undefined.";
	exit 0
fi

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
url=$1

if [[ $url =~ $regex ]]; then 
	output=$(pageres --crop "$url" $resolutions)
	echo "Saved screenshot(s) to Desktop"
else
	echo "Input is not a valid url"
fi