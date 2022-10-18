#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Look up in Dictionary
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/dictionary.icns
# @raycast.packageName Dictionary

# Documentation:
# @raycast.description Look up selected text in Dictionary
# @raycast.author yayiji
# @raycast.authorURL https://github.com/yayiji

tell application "System Events"
    keystroke "c" using {command down}
    delay 0.1
    do shell script "open dict://" & the clipboard
end

