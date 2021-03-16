#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tunnelblick: Disconnect All
# @raycast.mode silent
# @raycast.packageName Tunnelblick
#
# Optional parameters:
# @raycast.icon images/tunnelblick.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Disconnect all connected VPN configurations.
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

on run argv
    tell application "Tunnelblick" to disconnect all
    return # Discard Output
end run
