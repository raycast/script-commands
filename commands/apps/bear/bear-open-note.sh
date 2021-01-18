#!/bin/bash

# Raycast Script Command Template
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Bear Note
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
# @raycast.currentDirectoryPath ~
# @raycast.packageName Bear
# @raycast.argument1 { "type": "text", "placeholder": "Title" }

open "bear://x-callback-url/open-note?title=${1// /%20}"
