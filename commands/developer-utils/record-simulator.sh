#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Simulator
# @raycast.mode compact
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.author Maxim Krouk
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Records simulator to Downloads folder
# @raycast.needsConfirmation true
# @raycast.icon 📱
# @raycast.argument1 { "type": "text", "placeholder": "Filename" }
# @raycast.currentDirectoryPath ~/Downloads

clipboard=$1
filePath=~/Downloads/$clipboard.mp4
xcrun simctl io booted recordVideo $filePath
open -R $filePath
