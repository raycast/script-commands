#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Trash
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName System

# Documentation:
# @raycast.description Clear Trash
# @raycast.author chitwan_bindal
# @raycast.authorURL https://raycast.com/chitwan_bindal

try
    tell application "Finder"
        if (count of items in trash) is 0 then
            log "The trash is already empty."
        else
            empty the trash
            log "Trash has been emptied successfully."
        end if
    end tell
on error errMsg
    log "An error occurred: " & errMsg
end try
