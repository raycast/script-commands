#!/bin/bash

# Dependency: requires iconsur (https://github.com/rikumi/iconsur)
# Install via Homebrew: `brew install iconsur`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Change Application Icon
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🅱️
# @raycast.argument1 { "type": "text", "placeholder": "Application" }
# @raycast.argument2 { "type": "text", "placeholder": "Password (store apps)", "secure": true, "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Use Local Icon (y)" , "optional": true }
# @raycast.packageName iconsur

# Documentation:
# @raycast.description Change App Icons to Match Big Sur
# @raycast.author StevenRCE0
# @raycast.authorURL https://github.com/StevenRCE0

# Test iconsur
t=$(which iconsur)
if [ -z "$t" ]; then
    echo "Iconsur not found, install using brew install iconsur"
    exit -1
fi

# Test file
if [ ! -d "/Applications/$1.app" ]; then
    echo "Application not found, make sure it's in /Application folder"
    exit -2
fi

if [ $3 == "y" -o $3 == "Y"]; then
    loc="-l"
else
    loc=""
fi

if [ -n $2 ]; then
    echo $2|sudo -S iconsur set "/Applications/$1.app" $loc
else
    iconsur set "/Applications/$1.app" $loc
fi

echo "Icon changed successfully"
