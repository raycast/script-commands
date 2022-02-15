#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close all currently open Finder windows.
# @raycast.mode silent
# @raycast.packageName Navigation
#
# Optional parameters:
# @raycast.icon 🔪
#
# Documentation:
# @raycast.description Close all open Finder windows. They add up. 
# @raycast.author Alexander Steffen
# @raycast.authorURL https://github.com/alexjsteffen

tell application "Finder" to close windows
