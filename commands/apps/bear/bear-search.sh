#!/bin/bash

# Raycast Script Command Template
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Bear
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
# @raycast.currentDirectoryPath ~
# @raycast.packageName Bear
# @raycast.argument1 { "type": "text", "placeholder": "Term", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Tag", "optional": true }

open "bear://x-callback-url/search?term=${1// /%20}&tag=${2// /%20}"
