#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open current Finder directory in iTerm
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/iterm-logo.png
#
# Documentation:
# @raycast.description Open curren Finder directory in iTerm
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "Finder"
    set pathList to (quoted form of POSIX path of (folder of the front window as alias))
    set command to "clear; cd " & pathList
end tell

tell application "iTerm"
    activate
    set hasNoWindows to ((count of windows) is 0)
    if hasNoWindows then
        create window with default profile
    end if
    select first window

    tell the first window
        if hasNoWindows is false then
            create tab with default profile
        end if
        tell current session to write text command
    end tell
end tell
