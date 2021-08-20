#!/bin/bash

# Note: CleanShot X v3.8.1 required
# Install from https://cleanshot.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Annotate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/annotate.png
# @raycast.packageName CleanShot X
# @raycast.argument1 { "type": "text", "placeholder": "Filepath", "optional": true }

# Documentation:
# @raycast.author CleanShot X
# @raycast.authorURL https://twitter.com/CleanShot_app
# @raycast.description Opens specified file in Annotate.

if [[ -z "$1" ]]
then 
  open "cleanshot://open-annotate"
else
  open "cleanshot://open-annotate?filepath=$1"
fi