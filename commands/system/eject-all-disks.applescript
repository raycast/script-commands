#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Eject All Disks
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 📀

# Documentation:
# @raycast.description Ejects all mounted disk images.

tell application "Finder" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)
