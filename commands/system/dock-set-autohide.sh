#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dock Autohide
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "dropdown", "placeholder": "On/Off", "data": [{"title": "Off", "value": "false"}, {"title": "On", "value": "true"}]  }
# @raycast.packageName System

# Documentation:
# @raycast.description Set the dock autohide
# @raycast.author j3lte
# @raycast.authorURL https://raycast.com/j3lte

defaults write com.apple.dock autohide -bool $1; killall Dock
