#!/bin/bash

# @raycast.title Add to Bear
# @raycast.author Tanay Nistala
# @raycast.authorURL https://github.com/tanaynistala
# @raycast.description Add a new note to Bear.
#
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
#
# @raycast.mode silent
# @raycast.packageName Bear
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Title" }
# @raycast.argument2 { "type": "text", "placeholder": "Content", "optional": true}
# @raycast.argument3 { "type": "text", "placeholder": "Use Clipboard?", "optional": true }

open "bear://x-callback-url/create?title=${1// /%20}&clipboard=${3// /%20}&text=${2// /%20}"

echo "Note created!"
