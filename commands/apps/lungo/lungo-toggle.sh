#!/bin/bash

# Note: Lungo v2.0.4 required
# Install via Mac App Store: https://apps.apple.com/app/id1263070803

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/lungo.png
# @raycast.packageName Lungo

# Documentation:
# @raycast.author Lungo
# @raycast.authorURL https://sindresorhus.com/lungo
# @raycast.description Toggle Lungo.
# @raycast.argument1 { "type": "text", "placeholder": "hours", "optional": true, "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "minutes", "optional": true, "percentEncoded": true }

open --background "lungo:toggle?hours=$1&minutes=$2"
