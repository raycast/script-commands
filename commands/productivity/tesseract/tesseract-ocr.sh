#!/bin/bash

# Dependency: This script requires the `tesseract` cli to be installed: https://github.com/tesseract-ocr/tesseract
# Install via homebrew: `brew install tesseract`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title OCR Screenshot
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔍
# @raycast.argument1 { "type": "text", "placeholder": "Language", "optional": true }
# @raycast.packageName tesseract

# Documentation:
# @raycast.description Tesseract OCR
# @raycast.author Diego Lopes
# @raycast.authorURL https://github.com/Dihgg

if ! command -v tesseract &> /dev/null; then
    echo "tesseract command is required (https://github.com/tesseract-ocr/tesseract)"
    exit 1;
fi

TEMP_FILE=$(mktemp)
screencapture -i "$TEMP_FILE"
LANG=${1:-eng}
tesseract "$TEMP_FILE" stdout -l $LANG | LANG=en_US.UTF-8 pbcopy
echo "Gathered text copied to clipboard"
