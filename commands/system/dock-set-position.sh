#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dock Position
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "dropdown", "placeholder": "Position on Screen", "data": [{"title": "Left", "value": "left"}, {"title": "Right", "value": "right"}, {"title": "Bottom", "value": "bottom"}]  }
# @raycast.packageName System

# Documentation:
# @raycast.description Set the position of the Dock in the screen
# @raycast.author Jelte Lagendijk
# @raycast.authorURL https://raycast.com/j3lte

defaults write com.apple.dock orientation -string $1; killall Dock
