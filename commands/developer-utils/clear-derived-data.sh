#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Derived Data
# @raycast.mode compact
# @raycast.packageName Xcode

# Optional parameters:
# @raycast.icon 🧹

rm -rf ~/Library/Developer/Xcode/DerivedData
echo "Removed all derived data"
