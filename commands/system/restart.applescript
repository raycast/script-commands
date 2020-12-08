#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon ♻️

# Documentation:
# @raycast.description Restarts computer.

tell application "Finder" to restart
