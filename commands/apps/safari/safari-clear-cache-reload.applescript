#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Cache and Refresh Page
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon images/safari.png
#
# Documentation:
# @raycast.description This script clears cache and reloads the page of the frontmost Safari window.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

tell application "Safari" to activate
tell application "System Events" to keystroke "r" using {option down, command down} --warning: undocumented can change w/o notice
