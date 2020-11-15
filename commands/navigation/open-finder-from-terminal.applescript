#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Current Terminal Directory in Finder
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 📟
#
# Documentation:
# @raycast.description Open curren terminal directory in Finder
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "Terminal"
    if not (exists window 1) then reopen
        activate
    if busy of window 1 then
        tell application "System Events" to keystroke "t" using command down
    end if
    do script "open -a Finder ./" in window 1
end tell