#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tunnelblick: Connect
# @raycast.mode silent
# @raycast.packageName Tunnelblick
#
# Optional parameters:
# @raycast.icon images/tunnelblick.png
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Configuration" }
#
# Documentation:
# @raycast.description Connect a VPN configuration.
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

on run argv
    tell application "Tunnelblick" to connect (item 1 of argv)
    return # Discard Output
end run
