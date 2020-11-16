#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Derived Data
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🧹
# @raycast.packageName Xcode

rm -rf ~/Library/Developer/Xcode/DerivedData
echo "Removed all derived data"
