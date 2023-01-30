#!/bin/bash

# Dependency: `brew install pngpaste coreutils`
# pngpaste required to grab image from clipboard
# coreutils required to create temp file with suffix

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Image
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Clipboard

# Documentation:
# @raycast.description Open Image from Clipboard in Preview for OCR or other purposes.
# @raycast.author xxchan
# @raycast.authorURL https://github.com/xxchan

tempfile=$(gmktemp --suffix=.png) && pngpaste $tempfile && open $tempfile
