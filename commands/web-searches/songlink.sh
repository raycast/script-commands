#!/usr/bin/env bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Songlink
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎵
# @raycast.argument1 { "type": "text", "placeholder": "ARTIST + SONG OR ALBUM" }

# Documentation:
# @raycast.description Search + copy https://song.link URL to clipboard for easy sharing
# @raycast.author Alan Berman
# @raycast.authorURL https://github.com/thealanberman

if ! command -v jq &> /dev/null; then
      echo "jq command is required (https://stedolan.github.io/jq/)";
      exit 1;
fi

searchterm=$(IFS=" "; echo ${@})
URL="https://itunes.apple.com/search?term=${searchterm}&country=US&entity=song,album"
URL=${URL// /%20}
# echo $URL
track_id=$(curl --silent $URL | jq -r .results[0].trackId)
echo "https://song.link/us/i/${track_id}" | pbcopy
