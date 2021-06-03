#!/bin/bash

# Note: Sip X v2.5.3 required
# Install from https://sipapp.io

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title  Add Color to History
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/sip.png
# @raycast.packageName Sip
# Documentation:
# @raycast.author Sip
# @raycast.authorURL https://twitter.com/sip_app/
# @raycast.description  Add a color to your Sip history.
# @raycast.argument1 { "type": "text", "placeholder": "Name" }
# @raycast.argument2 { "type": "text", "placeholder": "HEX" }

open "sip://color/hex/${1}/#"${2//#}"
