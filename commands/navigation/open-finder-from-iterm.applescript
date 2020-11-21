#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open current iTerm directory in Finder
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/iterm-logo.png
#
# Documentation:
# @raycast.description Open curren iTerm directory in Finder
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "iTerm"
    tell the current session of current window
        write text "open -a Finder ./"
    end tell   
end tell
