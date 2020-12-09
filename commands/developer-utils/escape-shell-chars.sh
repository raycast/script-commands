#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Escape shell string
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.description Escapes shell character string and copies it again.

escaped=$(pbpaste) && printf '%q' "$escaped" | pbcopy
echo "Encoded URL"
