#!/bin/bash

# Dependencies:
# macOCR: https://github.com/schappim/macOCR

# Recommended installation:
# brew install schappim/ocr/ocr

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run OCR
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName macOCR
# @raycast.icon 📸
# @raycast.argument1 { "type": "text", "placeholder": "Language (default: en-US)", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

result=$(ocr -l ${1:-"en-US"})
echo $result | tee >(pbcopy)
