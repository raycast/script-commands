#!/bin/bash

# Dependency: `brew install pngpaste tesseract`
# pngpaste required to grab image from clipboard
# tesseract required to OCR

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title OCR Image
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Clipboard

# Documentation:
# @raycast.description OCR Image from Clipboard
# @raycast.author xxchan
# @raycast.authorURL https://github.com/xxchan

# credit to @laixintao https://www.kawabangga.com/posts/4876

pngpaste - | tesseract stdin stdout
