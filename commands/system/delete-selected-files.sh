#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete Selected Files
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗑
# @raycast.packageName System

# Documentation:
# @raycast.description Move selected files in Finder to Trash
# @raycast.author Vicent
# @raycast.authorURL https://github.com/vigosan

# Get selected files from Finder using AppleScript (using newline as delimiter)
selected_files=$(osascript <<'ENDAPPLE'
tell application "Finder"
    set selectedItems to selection
    if (count of selectedItems) is 0 then
        return "NO_SELECTION"
    end if

    set filePaths to {}
    repeat with anItem in selectedItems
        set end of filePaths to POSIX path of (anItem as alias)
    end repeat

    set text item delimiters of AppleScript to linefeed
    return filePaths as text
end tell
ENDAPPLE
)

# Check if any files are selected
if [ "$selected_files" = "NO_SELECTION" ]; then
    exit 1
fi

# Convert the text list to array (AppleScript returns newline-separated paths)
files=()
while IFS= read -r line; do
    [[ -n "$line" ]] && files+=("$line")
done <<< "$selected_files"

# Move each file to trash using AppleScript
for file in "${files[@]}"; do
    # Move to trash using AppleScript (this is the native macOS way)
    osascript -e "tell application \"Finder\" to delete POSIX file \"$file\"" >/dev/null 2>&1
done
