#!/bin/bash

# Dependency: This script requires `pandoc`: https://pandoc.org/installing.html

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Raw HTML to Rich Text on Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Conversions
# @raycast.description This script will convert raw HTML on your clipboard to rich text. It requires pandoc to be installed on your system.

# Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly

pbpaste | pandoc -f html -t rtf -s | pbcopy -pboard general -Prefer rtf