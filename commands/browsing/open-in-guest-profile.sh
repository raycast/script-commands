#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in guest profile
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Browser

# Documentation:
# @raycast.description Open current website in guest profile/mode
# @raycast.author JD Solanki
# @raycast.authorURL https://github.com/jd-solanki

############################################
## Set your browser app                   ##
## "Google Chrome"                        ##
## "Brave Browser"                        ##
############################################

browser="Google Chrome"

URL=$(osascript -e "tell application \"$browser\" to get URL of active tab of first window")

open -a "$browser" -n --args --guest --new-window "$URL"

