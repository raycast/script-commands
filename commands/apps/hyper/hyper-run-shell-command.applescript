#!/usr/bin/osascript

# Note: Hyper required
# Install via Hyper.is: https://hyper.is/

# Dependency: This script requires `hyperalfred` (https://github.com/gjuchault/hyperalfred)
# Install via Hyper: `hyper i hyperalfred`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run Shell Command
# @raycast.mode silent
# @raycast.packageName Hyper

# Optional parameters:
# @raycast.icon images/hyper.png
# @raycast.currentDirectoryPath ~
# @raycast.argument1 { "type": "text", "placeholder": "Command" }

# Documentation:
# @raycast.description Run a terminal using Hyper
# @raycast.author Eliot Hertenstein
# @raycast.authorURL https://github.com/eIiot

on run argv
  write_to_file( (item 1 of argv) , "./.hyper_plugins/hyperalfred.txt", false)
  try
    tell application "Hyper" to activate
  on error e
    log "Hyper is required (https://hyper.is)"
    -- return false
  end try
end run

on write_to_file(this_data, target_file, append_data)
  try
    tell application "System Events" to exists file target_file
    if not the result then do shell script "> " & quoted form of target_file
    set the open_target_file to open for access target_file with write permission
    if append_data is false then set eof of the open_target_file to 0
    write this_data to the open_target_file starting at eof
    close access the open_target_file
    return true
  on error e
    try
      log "hyperalfred is required (https://github.com/gjuchault/hyperalfred)."
      close access target_file
    end try
    return false
  end try
end write_to_file