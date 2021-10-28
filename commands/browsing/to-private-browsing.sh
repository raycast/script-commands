#!/bin/bash

############################################
## Set your browser app                   ##
## "Google Chrome"                        ##
## "Brave Browser"                        ##
############################################

browser="Google Chrome"

# @raycast.title Current Website to Private Browser
# @raycast.author raulanatol
# @raycast.authorURL https://github.com/raulanatol
# @raycast.description Open the current site in a private browser

# @raycast.icon 🥽
# @raycast.mode silent
# @raycast.packageName Browser
# @raycast.schemaVersion 1

URL=$(osascript -e "tell application \"$browser\" to get URL of active tab of first window")

open -a "$browser" -n --args --incognito --new-window "$URL"

