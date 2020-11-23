#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle System Appearance
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🌗
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda
# @raycast.description Script Command to switch between the system appearance, light and dark mode.

tell application "System Events" to tell appearance preferences to set dark mode to not dark mode
