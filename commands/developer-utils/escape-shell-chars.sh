#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Escape String for Shell
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.description Escapes shell character string and copies it again.

escaped=$(pbpaste) && printf '%q' "$escaped" | pbcopy
echo "Escaped string for shell"
