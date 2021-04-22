#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Item to Reading List
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon images/safari.png
# @raycast.argument1 { "type": "text", "placeholder": "Link" }
# @raycast.argument2 { "type": "text", "placeholder": "Title", "optional": true }

# @Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Add a new Reading List item with the given URL. Allows a custom title to be specified.

on run argv
  try
    set linkArgument to item 1 of argv as text
    set titleArgument to item 2 of argv as text

    if titleArgument is equal to "" then
      tell application "Safari" to add reading list item linkArgument
    else
      tell application "Safari" to add reading list item linkArgument with title titleArgument
    end if
    
    log "Added item to reading list"
  on error errorMessage number errorNumber
    log errorMessage
    log "Failed to add item to reading list"
    return errorNumber
  end try
end run
