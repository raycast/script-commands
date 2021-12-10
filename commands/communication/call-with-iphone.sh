#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Call with iPhone
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📱
# @raycast.argument1 { "type": "text", "placeholder": "+1 514 555 1212" }
# @raycast.packageName Communication

# Documentation:
# @raycast.description Place a telephone call via your iPhone on Wi-Fi.
# @raycast.author Alexander JH Steffen
# @raycast.authorURL https://github.com/alexjsteffen

sleep 1
open "tel://$1"


