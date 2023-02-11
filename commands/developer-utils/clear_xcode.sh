#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear All Related Junk
# @raycast.mode compact
# @raycast.packageName Xcode
#
# Optional parameters:
# @raycast.icon 🧹
#
# Documentation:
# @raycast.description This script clears all Xcode related junk.
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

rm -rf ~/Library/Caches/CocoaPods
rm -rf ~/Library/Caches/org.carthage.CarthageKit

xcrun simctl delete unavailable 

rm -rf ~/Library/Developer/Xcode/Archives
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Developer/Xcode/iOS\ Device\ Logs/

echo "Junk removed!"
