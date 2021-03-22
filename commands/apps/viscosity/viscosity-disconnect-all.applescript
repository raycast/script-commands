#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Viscosity: Disconnect All
# @raycast.mode silent
# @raycast.packageName Viscosity
#
# Optional parameters:
# @raycast.icon images/viscosity.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Disconnect all connected VPN configurations.
# @raycast.author Luigi Cardito (credits Achille Lacoin https://github.com/pomdtr)
# @raycast.authorURL https://github.com/lcardito

on run argv
    tell application "Viscosity" to disconnectall
    return # Discard Output
end run
