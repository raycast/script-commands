#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Empty Trash
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🗑

# Documentation:
# @raycast.description Empty the trash.

on run
  try
    tell application "Finder" to empty trash
  end try
end run