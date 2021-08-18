#!/bin/bash

# Upload Latest Screenshot to Imgur
# Fahim Faisal
# Code is free to use. Do whatever you want with it

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Upload Latest Screenshot to Imgur
# @raycast.mode silent
# @raycast.packageName Upload to Imgur

#
# Optional parameters:
# @raycast.icon ☁️
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Upload your last screenshot to Imgur and copy the image link to clipboard
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9


# Get screenshot location and latest screenshot
DIR=$(defaults read com.apple.screencapture location)
FILE=$(ls -t "$DIR" | head -n 1)
FILELOC="$DIR/$FILE"

#Client ID, use your own to avoid limits. Get from https://api.imgur.com/oauth2/addclient
client_id="6b1da49ab5fce27"

function upload {
	curl -s -H "Authorization: Client-ID $client_id" -H "Expect: " -F "image=$1" https://api.imgur.com/3/image.xml
}

output=$(upload "@$FILELOC") 2>/dev/null

if echo "$output" | grep -q 'success="0"'; then
    echo "From Imgur: Upload Error, try again" >&2
else
    #grab the image link and delete hash from curl response
    url="${output##*<link>}"
    url="${url%%</link>*}"
    delete_hash="${output##*<deletehash>}"
    delete_hash="${delete_hash%%</deletehash>*}"

    #Copy to clipboard
    echo -n "$url" | pbcopy
    echo "Link copied to clipboard"
fi
