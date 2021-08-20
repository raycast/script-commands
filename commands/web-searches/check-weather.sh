#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Check Weather
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌦
# @raycast.packageName wttr.in
# @raycast.argument1 { "type": "text", "placeholder": "Location", "optional": true}
# @raycast.argument2 { "type": "text", "placeholder": "Options", "optional": true}

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

# $1 (Location) - e.g. "warsaw", "warsaw poland", "warsaw usa"; default: current location
# $2 (Options) - e.g. "0", "1", "0q", "format=v2"; more info:
# https://wttr.in/:help
# https://github.com/chubin/wttr.in
open "https://wttr.in/$1?$2"
