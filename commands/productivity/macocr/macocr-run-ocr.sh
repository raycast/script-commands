#!/bin/bash

# Dependency: This script requires `macOCR` to be installed: https://github.com/schappim/macOCR
# Install via homebrew: `brew install schappim/ocr/ocr`

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

if ! command -v ocr &> /dev/null; then
   echo "macOCR has to be installed (https://github.com/schappim/macOCR)";
   exit 1;
fi

result=$(ocr -l ${1:-"en-US"})
echo $result | tee >(pbcopy)
