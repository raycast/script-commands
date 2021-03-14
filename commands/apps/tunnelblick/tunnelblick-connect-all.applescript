#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tunnelblick: Connect All
# @raycast.mode silent
# @raycast.packageName TunnelBlick
#
# Optional parameters:
# @raycast.icon images/tunnelblick.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Connect all unconnected VPN configurations.
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

on run argv
    tell application "Tunnelblick" to connect all
    return # Discard Output
end run
