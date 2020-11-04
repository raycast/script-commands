#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Simulator
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📱

clipboard=$(pbpaste)
filePath=~/Downloads/$clipboard.mp4
xcrun simctl io booted recordVideo $filePath
open -R $filePath
