#!/usr/bin/osascript

# Raycast Script Command Template
#
# Duplicate this file and remove ".template" from the filename to get started.
# See full documentation here: https://github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title My First Script
# @raycast.mode fullOutput
# @raycast.packageName Raycast Scripts
#
# Optional parameters:
# @raycast.icon 🤖
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Arg1" }
#
# Documentation:
# @raycast.description Write a nice and descriptive summary about your script command here 
# @raycast.author Your name
# @raycast.authorURL An URL for one of your social medias

on run argv
  log "Hello from My First Script: " & ( item 1 of argv )
end run
