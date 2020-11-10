#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open current Finder directory in Terminal
# @raycast.mode silent
# @raycast.packageName Navigation
#
# Optional parameters:
# @raycast.icon 📟
#
# Documentation:
# @raycast.description Open curren Finder directory in terminal
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "Finder"
    set pathList to (quoted form of POSIX path of (folder of the front window as alias))
    set command to "clear; cd " & pathList
end tell
  
tell application "System Events"
    set isRunning to (exists (processes where name is "iTerm")) or (exists (processes where name is "iTerm2"))
end tell
  
if application "iTerm" is running then
    tell application "iTerm"
        activate
        set hasNoWindows to ((count of windows) is 0)
        if isRunning and hasNoWindows then
            create window with default profile
        end if
        select first window

        tell the first window
            if isRunning and hasNoWindows is false then
                create tab with default profile
            end if
            tell current session to write text command
        end tell
    end tell
else
    tell application "Terminal"
        if not (exists window 1) then reopen
            activate
        if busy of window 1 then
            tell application "System Events" to keystroke "t" using command down
        end if
        do script command in window 1
    end tell
end if


