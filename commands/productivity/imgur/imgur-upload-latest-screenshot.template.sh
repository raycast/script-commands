#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Upload Latest Screenshot to Imgur
# @raycast.mode silent
# @raycast.packageName Upload to Imgur
#
# Optional parameters:
# @raycast.icon ☁️
#
# Documentation:
# @raycast.description Upload your last screenshot to Imgur and copy the image link to clipboard
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9


# Get screenshot location and latest screenshot
DIR=$(defaults read com.apple.screencapture location)
FILE=$(ls -t "$DIR" | head -n 1)
FILELOC="$DIR/$FILE"

#Client ID, use your own client ID. Get it from https://api.imgur.com/oauth2/addclient (Select anonymous usage as auth type)
client_id="" #CAN NOT BE EMPTY

if [ "$client_id" == "" ]; then
    echo "No API Key found. Configure your own key before running"
    exit -1
fi

function upload {
	curl --location --request POST 'https://api.imgur.com/3/image' --header "Authorization: Client-ID $client_id" --form "image=$1"
}

output=$(upload "@$FILELOC") 2>/dev/null

if echo "$output" | grep -q 'success="0"'; then
    echo "From Imgur: Upload Error, try again" >&2
else
    #grab the image link and delete hash from curl response
    url="${output##*\"link\":\"}"
    url="${url%%\"\}*}"
    delete_hash="${output##*<deletehash>}"
    delete_hash="${delete_hash%%</deletehash>*}"

    #Copy to clipboard
    echo -n "$url" | pbcopy
    echo "Link copied to clipboard"
fi
