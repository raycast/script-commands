#!/bin/bash

# Raycast Script Command Template
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Todo in Bear
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/bear-light.png
# @raycast.iconDark images/bear-dark.png
# @raycast.currentDirectoryPath ~
# @raycast.packageName Bear
# @raycast.argument1 { "type": "text", "placeholder": "Search Query", "optional": true }

open "bear://x-callback-url/todo?search=${1// /%20}"
