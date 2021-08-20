#!/bin/bash

# Note: CleanShot X v3.8.1 required
# Install from https://cleanshot.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Capture Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/capture-text.png
# @raycast.packageName CleanShot X
# @raycast.argument1 { "type": "text", "placeholder": "Filepath", "optional": true }

# Documentation:
# @raycast.author CleanShot X
# @raycast.authorURL https://twitter.com/CleanShot_app
# @raycast.description Opens Text Recognition (OCR) tool or extracts text from the specified file.

if [[ -z "$1" ]]
then 
  open "cleanshot://capture-text"
else
  open "cleanshot://capture-text?filepath=$1"
fi