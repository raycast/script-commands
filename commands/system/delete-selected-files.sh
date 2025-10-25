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

if [ "$selected_files" = "NO_SELECTION" ]; then
    exit 1
fi

files=()
while IFS= read -r line; do
    [[ -n "$line" ]] && files+=("$line")
done <<< "$selected_files"

file_count=${#files[@]}

for file in "${files[@]}"; do
    osascript -e "tell application \"Finder\" to delete POSIX file \"$file\"" >/dev/null 2>&1
done

if [ $file_count -eq 1 ]; then
    message="1 item moved to Trash"
else
    message="$file_count items moved to Trash"
fi

osascript -e "display notification \"$message\" with title \"Trash\""
