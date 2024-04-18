#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dock Autohide Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName System

# Documentation:
# @raycast.description Toggle the dock autohide
# @raycast.author j3lte
# @raycast.authorURL https://raycast.com/j3lte

autohide=$(defaults read com.apple.dock autohide)

if [[ $autohide == 1 ]]; then
    defaults write com.apple.dock autohide -bool false; killall Dock
else
    defaults write com.apple.dock autohide -bool true; killall Dock
fi
