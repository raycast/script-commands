#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Eject All Disks
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📀

tell application "Finder" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)
