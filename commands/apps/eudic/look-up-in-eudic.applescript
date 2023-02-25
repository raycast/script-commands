#!/usr/bin/osascript

# Dependency: Eudic required
# Install via Mac App Store: https://apps.apple.com/app/id402380914

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Look up Word
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/eudic.png
# @raycast.argument1 { "type": "text", "placeholder": "word" }
# @raycast.packageName Eudic

# Documentation:
# @raycast.description look up in eudic
# @raycast.author jingyi
# @raycast.authorURL https://jingyi.blog

on run argv
    # FIXME known issue of Eudic. Force open it
    do shell script "open -b com.eusoft.eudic"
    do shell script "open -b com.eusoft.eudic"
    tell application id "com.eusoft.eudic"
        activate
        show dic with word (item 1 of argv)
    end tell
end run
