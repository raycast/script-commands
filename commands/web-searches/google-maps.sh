#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Google Maps
# @raycast.mode silent
# @raycast.packageName Google Maps

# Optional parameters:
# @raycast.icon images/google-map.png
# @raycast.argument1 { "type": "text", "placeholder": "Location", "optional": true}
# @raycast.argument2 { "type": "text", "placeholder": "Destination", "optional": true}

first_argument=${1// /+}
second_argument=${2// /+}

if [ "$1" != "" ]; then
        if [ "$2" = "" ]; then
                open "https://www.google.com/maps/dir/?api=1&origin=$first_argument"
        else
                open "https://www.google.com/maps/dir/?api=1&origin=$first_argument&destination=$second_argument"
        fi
elif [ "$1" = "" ] && [ "$2" != "" ]; then
        open "https://www.google.com/maps/dir/?api=1&origin=Current+Location&destination=$second_argument"
else
        open "https://www.google.com/maps"
fi
