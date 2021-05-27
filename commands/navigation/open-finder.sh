#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Finder
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔍
# @raycast.argument1 { "type": "text", "optional": true, "placeholder": "Placeholder" }
# @raycast.packageName Navigation

# Documentation:
# @raycast.description Open Finder at $HOME or argument location
# @raycast.author Afraz

LOCATION=$1

if ! [[ "$LOCATION" =~ ^/ ]]; then
  LOCATION="$HOME/$LOCATION"
fi

open "$LOCATION"