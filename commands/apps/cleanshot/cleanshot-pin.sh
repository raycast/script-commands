#!/bin/bash

# Note: CleanShot X v3.5.1 required
# Install from https://cleanshot.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pin to the Screen
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/pin.png
# @raycast.packageName CleanShot X
# @raycast.argument1 { "type": "text", "placeholder": "Filepath", "optional": true }

# Documentation:
# @raycast.author CleanShot X
# @raycast.authorURL https://twitter.com/CleanShot_app
# @raycast.description Pin a screenshot to the screen.

if [[ -z "$1" ]]
then 
  open "cleanshot://pin"
else
  open "cleanshot://pin?filepath=$1"
fi