#!/bin/bash

# @raycast.title Open Note
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Open the specified note in Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Title" }

open "bear://x-callback-url/open-note?title=${1// /%20}"
