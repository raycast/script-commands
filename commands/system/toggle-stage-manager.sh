#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Stage Manager
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🪟

# Documentation:
# @raycast.description Toggle Stage Manager on or off
# @raycast.author Morgan Williams
# @raycast.authorURL https://www.raycast.com/morgan_williams

STATE=$(defaults read com.apple.WindowManager GloballyEnabled 2>/dev/null)
if [[ "${STATE}" = 0 ]]; then
	defaults write com.apple.WindowManager GloballyEnabled -bool true
	echo "Stage Manager enabled"
else
	defaults write com.apple.WindowManager GloballyEnabled -bool false
	echo "Stage Manager disabled"
fi
killall WindowManager
