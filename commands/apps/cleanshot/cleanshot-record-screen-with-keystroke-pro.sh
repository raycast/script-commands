#!/bin/bash

# Note: CleanShot X required
# Install from https://cleanshot.com
#
# Keystroke Pro required
# Install from https://apps.apple.com/app/id1572206224?ct=ixeau

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Screen With Keystroke Pro
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/record-screen-keystroke-pro.png
# @raycast.packageName CleanShot X

# Documentation:
# @raycast.author Danylo Zalizchuk
# @raycast.authorURL https://raycast.com/danulqua
# @raycast.description Start a screen recording with keystrokes using the Keystroke Pro app and save it as a video or an optimized GIF file.

open "/Applications/Keystroke Pro.app"
open "cleanshot://record-screen"
