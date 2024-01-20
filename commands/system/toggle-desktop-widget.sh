#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Desktop Widgets
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄

# Documentation:
# @raycast.author Federico Zivolo
# @raycast.authorURL https://github.com/FezVrasta

# Get the current value of the preference
current_value=$(defaults read com.apple.WindowManager StandardHideWidgets)

# Toggle the value
if [[ $current_value == 1 ]]; then
  new_value=0
else
  new_value=1
fi

# Write the new value to the preference
defaults write com.apple.WindowManager StandardHideWidgets -int $new_value
