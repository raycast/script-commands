#!/bin/bash

# Note: Sip X v2.5.3 required
# Install from https://sipapp.io

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Check Contrast
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/sip.png
# @raycast.packageName Sip
# Documentation:
# @raycast.author Sip
# @raycast.authorURL https://twitter.com/sip_app/
# @raycast.description Open Sip Contrast Checker.
# @raycast.argument1 { "type": "text", "placeholder": "HEX 1" }
# @raycast.argument2 { "type": "text", "placeholder": "HEX 2" }

open "sip://contrast/hex/"${1//#}","${2//#}""
