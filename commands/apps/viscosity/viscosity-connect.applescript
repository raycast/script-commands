#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Viscosity: Connect
# @raycast.mode silent
# @raycast.packageName Viscosity
#
# Optional parameters:
# @raycast.icon images/viscosity.png
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Configuration" }
#
# Documentation:
# @raycast.description Connect a VPN viscosity configuration.
# @raycast.author Luigi Cardito (credits Achille Lacoin https://github.com/pomdtr)
# @raycast.authorURL https://github.com/lcardito

on run argv
    tell application "Viscosity" to connect (item 1 of argv)
    return # Discard Output
end run
