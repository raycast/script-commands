#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Google Maps
# @raycast.mode silent
# @raycast.packageName Google Maps

# Optional parameters:
# @raycast.icon google-map.png
# @raycast.argument1 { "type": "text", "placeholder": "Location", "optional": true}
# @raycast.argument2 { "type": "text", "placeholder": "Destination", "optional": true}

first_argument=${1// /+}
second_argument=${2// /+}

if [$1 == ""]; then
	open "https://www.google.com/maps"
elif [$2 == ""]; then
	open "https://www.google.com/maps/search/$first_argument"
else
	open "https://www.google.com/maps/dir/$second_argument/$first_argument"
fi
