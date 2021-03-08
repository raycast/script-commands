#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Go to Artist in Apple Music
# @raycast.mode silent
# @raycast.packageName Music

# Optional parameters:
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl
# @raycast.description Go to Artist page in the Apple Music App
# @raycast.argument1 { "type": "text", "placeholder": "artist", "percentEncoded": true}
# @raycast.icon images/apple-music-logo.png

if ! command -v jq &> /dev/null; then
	echo "jq is required. Install using homebrew: brew install jq";
	exit 1;
fi

url=$(curl -s https://itunes.apple.com/search\?term=$1\&entity=musicArtist | jq '.results[0].artistLinkUrl' | sed 's/https/itms/g' | sed 's/"//g')
osascript -e 'on run {myurl}' -e 'open location myurl' -e 'end run' $url