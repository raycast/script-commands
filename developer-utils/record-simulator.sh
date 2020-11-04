#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Simulator
# @raycast.mode compact

# Optional parameters:
# @raycast.author Maxim Krouk
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Records simulator to Downloads folder with a filename from the clipboard
# @raycast.needsConfirmation true
# @raycast.icon 📱

clipboard=$(pbpaste)
filePath=~/Downloads/$clipboard.mp4
xcrun simctl io booted recordVideo $filePath
open -R $filePath
