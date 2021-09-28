#!/bin/bash

# Dependency: This script requires the `tesseract` cli to be installed: https://github.com/tesseract-ocr/tesseract
# Install via homebrew: `brew install tesseract`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title OCR Screenshot
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔍
# @raycast.argument1 { "type": "text", "placeholder": "Language", "optional": true }
# @raycast.packageName tesseract

# Documentation:
# @raycast.description Tesseract OCR
# @raycast.author Diego Lopes
# @raycast.authorURL https://github.com/Dihgg

# echo "Hello World! Argument1 value: "$1""
if ! command -v tesseract &> /dev/null; then
    echo "tesseract command is required (https://github.com/tesseract-ocr/tesseract)"
    exit 1;
fi

TEMP_DIR=$(mktemp -d)

screencapture -i "$TEMP_DIR/screenshot.png"
LANG=${1:-eng}

tesseract "$TEMP_DIR/screenshot.png" "$TEMP_DIR/ocr" -l $LANG
pbcopy < $TEMP_DIR/ocr.txt

echo "Gathered text copied to clipboard"
