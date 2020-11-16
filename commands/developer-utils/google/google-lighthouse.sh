#!/bin/bash

# Dependency: requires lighthouse (https://developers.google.com/web/tools/lighthouse#cli)
# Install via npm: `npm install -g lighthouse`

# @raycast.schemaVersion 1
# @raycast.title Lighthouse
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Open a Lighthouse report of URL in clipboard.
# @raycast.packageName Google
# @raycast.needsConfirmation true
# @raycast.icon images/google-lighthouse-logo.png
# @raycast.currentDirectoryPath ~/Desktop

if ! command -v lighthouse &> /dev/null; then
	echo "lighthouse is required (https://developers.google.com/web/tools/lighthouse#cli).";
	exit 1;
fi

clipboard=$(pbpaste)
regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $clipboard =~ $regex ]]; then 
	lighthouse --quiet --view "$clipboard"
fi

echo "Clipboard does not contain a URL."