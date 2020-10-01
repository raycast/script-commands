#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle System Appearance
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌗

tell application "System Events" to tell appearance preferences to set dark mode to not dark mode
