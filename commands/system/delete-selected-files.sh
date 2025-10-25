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
# @raycast.author Vicent Gozalbes
# @raycast.authorURL https://github.com/vigosan

file_count=$(osascript <<'ENDAPPLE'
tell application "Finder"
    set selectedItems to selection
    if (count of selectedItems) is 0 then
        return 0
    end if

    delete selectedItems
    return count of selectedItems
end tell
ENDAPPLE
)

if [ "$file_count" -eq 0 ]; then
    exit 1
fi

if [ $file_count -eq 1 ]; then
    message="1 item moved to Trash"
else
    message="$file_count items moved to Trash"
fi

osascript -e "display notification \"$message\" with title \"Trash\""
