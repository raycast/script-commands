#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clipboard to Imgur
# @raycast.mode silent
# @raycast.packageName Uploads Copied Image or Image from Clipboard

#
# Optional parameters:
# @raycast.icon 📋
#
# Documentation:
# @raycast.description Upload Image from your Clipboard and copy the image link to clipboard
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

#Dependency: pngpaste and imagemagick (Install via brew install pngpaste imagemagick)
#pngpaste required to grab image from clipboard
#imagemagick required to convert heic image to jpg (imgur doesnt accept heic files)

#pngpaste check
t=$(which pngpaste)
if [ -z "$t" ]; then
    echo "pngpaste not found, install using brew install pngpaste"
    exit -1
fi

#imagemagick check
m=$(which magick)
if [ -z "$m" ]; then
    echo "imagemagick not found, install using brew install imagemagick"
    exit -1
fi

#Client ID, use your own client ID. Get it from https://api.imgur.com/oauth2/addclient (Select anonymous usage as auth type)
client_id="" #CAN NOT BE EMPTY

if [ "$client_id" == "" ]; then
    echo "No API Key found. Configure your own key before running"
    exit -1
fi


function upload {
	curl --location --request POST 'https://api.imgur.com/3/image' --header "Authorization: Client-ID $client_id" --form "image=$1"
}

#Grab full file path from clipboard if there's an image
file_img=$(osascript -e "POSIX path of (the clipboard as «class furl»)")
ext="${file_img##*.}"

case "$ext" in
    png|jpg|jpeg|gif) #If image file is found in clipboard
        output=$(upload "@$file_img") 2>/dev/null
        ;;
    heic|HEIC) #HEIC conversion to JPG as Imgur doesnt suppot heic natively
        clip_img="$(mktemp).jpg"
        magick convert "${file_img}" "${clip_img}"
        echo "${clip_img}"
        output=$(upload "@$clip_img") 2>/dev/null
        ;;
    *)
        # check clipboard via pngpaste
        clip_img="$(mktemp).png"
        pngpaste "${clip_img}"
        output=$(upload "@$clip_img") 2>/dev/null
        ;;
esac

jobdone=1
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

    echo -n "$url" | sed 's/\\\//\//g' | pbcopy
    jobdone=0
fi

#Error handling is a solid "ehhh" (for now)
if [ "$jobdone" -ne 1 ]; then
    echo "Upload Successful, link copied to clipboard"
else
    echo "No image/image file found in clipboard, try again."
fi
