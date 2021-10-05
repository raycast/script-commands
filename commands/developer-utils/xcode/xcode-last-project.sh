#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Last Project
# @raycast.mode silent
# @raycast.packageName Developer Utilities
#
# Optional parameters:
# @raycast.icon images/xcode.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Open the last Xcode project 
# @raycast.author Sergey Korobyin
# @raycast.authorURL https://github.com/huangsemao

mdfind "(kMDItemContentType =='com.apple.xcode.project') || (kMDItemContentType == 'com.apple.dt.document.workspace') || (kMDItemContentType == 'com.apple.dt.playground')" -0 | xargs -0 ls -t | head -1 | cut -f1 -d: | awk '{print "\x27" $0 "\x27" }' | xargs  open