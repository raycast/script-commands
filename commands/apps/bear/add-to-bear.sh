#!/bin/bash

# Raycast Script Command Template
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add to Bear
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
# @raycast.currentDirectoryPath ~
# @raycast.packageName Bear
# @raycast.argument1 { "type": "text", "placeholder": "Title" }
# @raycast.argument2 { "type": "text", "placeholder": "Content", "optional": true}
# @raycast.argument3 { "type": "text", "placeholder": "Use Clipboard?", "optional": true }

open "bear://x-callback-url/create?title=${1// /%20}&clipboard=${3// /%20}&text=${2// /%20}"

echo "Note created!"
