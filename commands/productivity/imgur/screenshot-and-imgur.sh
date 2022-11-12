#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screenshot and Imgur
# @raycast.mode silent
# @raycast.packageName Opens Screenshot Interface and Uploads

#
# Optional parameters:
# @raycast.icon 📷
#
# Documentation:
# @raycast.description Opens default screenshot interface and immediately uploads and copies link to clipboard
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

#Client ID, use your own client ID. Get it from https://api.imgur.com/oauth2/addclient (Select anonymous usage as auth type)
client_id="" #CAN NOT BE EMPTY

if [ "$client_id" == "" ]; then
    echo "No API Key found. Configure your own key before running"
    exit -1
fi

function upload {
	curl --location --request POST 'https://api.imgur.com/3/image' --header "Authorization: Client-ID $client_id" --form "image=$1"
}

#Opens screenshot interface
screencapture -c -s

#Grabs the screenshot from clipboard into a png file, uploads
clip_img="$(mktemp).png"
pngpaste "${clip_img}"
output=$(upload "@$clip_img") 2>/dev/null

#Parse response from Imgur
if echo "$output" | grep -q 'success="0"'; then
    echo "From Imgur: Upload Error, try again" >&2
elif echo "$output" | grep -q 'Imgur is over capacity!'; then
    echo "From Imgur: Upload Error, try again" >&2
else
    url="${output##*\"link\":\"}"
    url="${url%%\"\}*}"
    delete_hash="${output##*<deletehash>}"
    delete_hash="${delete_hash%%</deletehash>*}"

    echo -n "$url" | pbcopy
    echo "Screenshotted and Uploaded, Image link copied to clipboard"
fi
