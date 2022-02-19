#!/bin/bash

# Note: Focus required
# Install from: https://heyfocus.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Custom Break
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/focus-logo.png
# @raycast.packageName Focus

# Documentation:
# @raycast.author Ernest Ojeh
# @raycast.authorURL https://github.com/namzo
# @raycast.description Start a custom break. If you don't enter any values, it uses the last break duration.

# @raycast.argument1 { "type": "text", "placeholder": "Minutes", "optional": true, "percentEncoded": true }

open "focus://break?minutes=${1}"