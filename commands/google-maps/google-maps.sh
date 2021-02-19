#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Google Maps
# @raycast.mode silent
# @raycast.packageName Google Maps

# Optional parameters:
# @raycast.icon google-map.png
# @raycast.argument1 { "type": "text", "placeholder": "Location"}
# @raycast.argument2 { "type": "text", "placeholder": "Destination", "optional": true}

if [$1 = false]; then
	open "https://www.google.com/maps"
elif [$2 = false]; then
	open "https://www.google.com/maps/search/${1// /+}"
else
	open "https://www.google.com/maps/dir/${2// /+}/${1// /+}"
fi
