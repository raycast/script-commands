#!/bin/bash

# @raycast.title Open Today
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Open the Today section in Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Search Query", "optional": true }

open "bear://x-callback-url/today?search=${1// /%20}"
