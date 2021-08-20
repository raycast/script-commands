#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Current Finder Directory in Terminal
# @raycast.mode silent
# @raycast.packageName Navigation
#
# Optional parameters:
# @raycast.icon 📟
#
# Documentation:
# @raycast.description Open current Finder directory in Terminal
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "Finder"
    -- Check if there's a selection; works if there's a window open or not.
    if selection is not {} then
        set i to item 1 of (get selection)

        -- If it's an alias, set the item to the original item.
        if class of i is alias file then
            set i to original item of i
        end if

        -- If it's a folder, use its path.
        if class of i is folder then
            set p to i
        else
            -- If it's an item, use its container's path.
            set p to container of i
        end if
    else if (window 1 exists) and (folder of window 1 exists) then
        -- If a window exist, use its folder property as the path.
        set p to folder of window 1
    else
        -- Fallback to the Desktop, as nothing is open or selected.
        set p to path to desktop folder
    end if

    set command to "cd " & quoted form of POSIX path of (p as alias) & ";clear;"
end tell

tell application "Terminal"
    if not (exists window 1) then reopen

    activate

    if busy of window 1 then
        tell application "System Events" to keystroke "t" using command down
    end if

    do script command in window 1
end tell

return ""
