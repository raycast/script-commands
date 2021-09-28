#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Recent Project
# @raycast.mode silent
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "Project name", "percentEncoded": true}
#
# Optional parameters:
# @raycast.icon images/xcode.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Open recent Xcode project
# @raycast.author Sergey Korobyin
# @raycast.authorURL https://github.com/huangsemao

mdfind "(kMDItemFSName == '*$1*'c) && ((kMDItemContentType =='com.apple.xcode.project') || (kMDItemContentType == 'com.apple.dt.document.workspace') || (kMDItemContentType == 'com.apple.dt.playground'))" -0 | xargs -0 ls -t | head -1 | cut -f1 -d: | awk '{print "\x27" $0 "\x27" }' | xargs  open