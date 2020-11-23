#!/bin/bash

# Dependency: requires lighthouse (https://developers.google.com/web/tools/lighthouse#cli)
# Install via npm: `npm install -g lighthouse`

# @raycast.schemaVersion 1
# @raycast.title Lighthouse
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open a Lighthouse report of URL.
# @raycast.packageName Google
# @raycast.icon images/google-lighthouse-logo.png
# @raycast.currentDirectoryPath ~/Desktop
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if ! command -v lighthouse &> /dev/null; then
	echo "lighthouse is required (https://developers.google.com/web/tools/lighthouse#cli).";
	exit 1;
fi

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $1 =~ $regex ]]; then 
	lighthouse --quiet --view "$1"
fi

echo "Input is not a valid URL."