#!/bin/bash

# Note: CleanShot X v3.8.1 required
# Install from https://cleanshot.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Quick Access Overlay
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/add-quick-access-overlay.png
# @raycast.packageName CleanShot X
# @raycast.argument1 { "type": "text", "placeholder": "Filepath" }

# Documentation:
# @raycast.author CleanShot X
# @raycast.authorURL https://twitter.com/CleanShot_app
# @raycast.description Opens a new Quick Access Overlay with the specified image or video.

open "cleanshot://add-quick-access-overlay?filepath=$1"