#!/bin/bash

# Install DND Me from https://runtimesharks.com/projects/dnd-me?ref=producthunt

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop DND
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔔
# @raycast.packageName DND Me

# Documentation:
# @raycast.description Stops DND via DND Me.
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com/projects/dnd-me

open "dndme://stop-dnd"

echo "DND off"
