#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dock Set Autohide
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "dropdown", "placeholder": "On/Off", "data": [{"title": "Off", "value": "false"}, {"title": "On", "value": "true"}]  }
# @raycast.packageName System

# Documentation:
# @raycast.description Set the Dock autohide
# @raycast.author Jelte Lagendijk
# @raycast.authorURL https://raycast.com/j3lte

defaults write com.apple.dock autohide -bool $1; killall Dock
