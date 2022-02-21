#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close All Finder Windows
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 🔪
#
# Documentation:
# @raycast.description Close all open Finder windows. 
# @raycast.author Alexander Steffen
# @raycast.authorURL https://github.com/alexjsteffen

tell application "Finder" to close windows
