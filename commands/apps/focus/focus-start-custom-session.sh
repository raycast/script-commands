#!/bin/bash

# Note: Focus required
# Install from: https://heyfocus.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Custom Focus Session
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/focus-logo.png
# @raycast.packageName Focus

# Documentation:
# @raycast.author Ernest Ojeh
# @raycast.authorURL https://github.com/namzo
# @raycast.description Start a custom focus session. If you don't enter any values, it starts an untimed focus session.

# @raycast.argument1 { "type": "text", "placeholder": "Hours", "optional": true, "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Minutes", "optional": true, "percentEncoded": true  }

open "focus://focus?hours=${1}&minutes=${2}"