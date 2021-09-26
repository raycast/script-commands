#!/bin/bash

# @raycast.title Xcode
# @raycast.author Sergey Korobyin
# @raycast.authorURL https://github.com/huangsemao
# @raycast.description Open recent xcode project

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Recent Xcode project
# @raycast.mode silent
# @raycast.icon images/xcode.png
# @raycast.packageName Xcode
# @raycast.argument1 { "type": "text", "placeholder": "Project name", "percentEncoded": true}

mdfind "(kMDItemFSName == '*$1*'c) && ((kMDItemContentType =='com.apple.xcode.project') || (kMDItemContentType == 'com.apple.dt.document.workspace') || (kMDItemContentType == 'com.apple.dt.playground'))" -0 | xargs -0 ls -t | head -1 | cut -f1 -d: | awk '{print "\x27" $0 "\x27" }' | xargs  open