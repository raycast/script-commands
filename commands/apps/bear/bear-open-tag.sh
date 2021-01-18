#!/bin/bash

# @raycast.title Open Tag
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Open the specified tag in Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Tag" }

open "bear://x-callback-url/open-tag?name=${1// /%20}"
