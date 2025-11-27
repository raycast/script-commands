#!/bin/bash

# Dependency: This script requires `qpdf` installed: https://github.com/qpdf/qpdf
# Install via homebrew: `brew install qpdf`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Compress PDF
# @raycast.mode compact
# @raycast.packageName QPDF

# Optional parameters:
# @raycast.icon 🗜️
# @raycast.argument1 { "type": "text", "placeholder": "Quality (0-100, default: 50)", "optional": true }

# Documentation:
# @raycast.description Compress selected PDF files. Note: This script requires 'qpdf' to be installed via Homebrew.
# @raycast.author Nicklas Jakobsen
# @raycast.authorURL https://github.com/nicklasjm

# Configuration
QUALITY="${1:-50}"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Check for qpdf dependency
if ! command -v qpdf &> /dev/null; then
    echo "Error: qpdf is not installed."
    echo "Run 'brew install qpdf' in Terminal."
    exit 1
fi

# Get files via AppleScript
SELECTED_FILES=$(osascript <<EOD
tell application "Finder"
    set theSelection to selection
    if theSelection is {} then
        return ""
    end if
    set output to ""
    repeat with theItem in theSelection
        set output to output & POSIX path of (theItem as alias) & "\n"
    end repeat
    return output
end tell
EOD
)

if [ -z "$SELECTED_FILES" ]; then
    echo "No files selected in Finder"
    exit 1
fi

IFS=$'\n'
count=0
last_output=""

# Loop through files and compress
for f in $SELECTED_FILES; do
    # Ignore non-PDF files
    if [[ "$f" != *.pdf && "$f" != *.PDF ]]; then
        continue
    fi

    filename=$(basename "$f")
    echo "Processing: $filename ($QUALITY%)..."

    dir=$(dirname "$f")
    base_filename=$(basename "$f" .pdf)
    
    # Filename format: Name_50%.pdf
    output="$dir/${base_filename}_${QUALITY}%.pdf"

    # Run qpdf
    # We use --recompress-flate to ensure images are unpacked and re-evaluated
    qpdf --compress-streams=y \
         --recompress-flate \
         --decode-level=generalized \
         --compression-level=9 \
         --optimize-images \
         --jpeg-quality="$QUALITY" \
         --object-streams=generate \
         "$f" "$output"
    
    if [ $? -eq 0 ]; then
        ((count++))
        last_output="$output"
    else
        echo "Error processing: $filename"
        sleep 2
    fi
done

# Show result
if [ $count -eq 0 ]; then
    echo "No files were created."
    exit 1
else
    # Reveal the last created file in Finder
    if [ -n "$last_output" ]; then
        open -R "$last_output"
    fi
    echo "Done! Saved as ..._${QUALITY}%.pdf"
fi