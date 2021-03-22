#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Viscosity: Connect All
# @raycast.mode silent
# @raycast.packageName Viscosity
#
# Optional parameters:
# @raycast.icon images/viscosity.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Connect all unconnected VPN configurations.
# @raycast.author Luigi Cardito (credits Achille Lacoin https://github.com/pomdtr)
# @raycast.authorURL https://github.com/lcardito

on run argv
    tell application "Viscosity" to connectall
    return # Discard Output
end run
