#!/usr/bin/osascript

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Create New File in Finder
# @raycast.mode silent
# @raycast.packageName System
# @raycast.description Create New File in Finder is a script to make your Finder better.You can use this script to create a plain text file.
# Optional parameters:
# @raycast.icon images/new-file.png

set file_name to "untitled"
set file_ext to ".txt"
set is_desktop to false

-- get folder path and if we're in desktop (no folder opened)
try
    tell application "Finder"
        set this_folder to (folder of the front Finder window) as alias
    end tell
on error
    -- no open folder windows
    set this_folder to path to desktop folder as alias
    set is_desktop to true
end try

-- get the new file name (do not override an already existing file)
tell application "System Events"
    set file_list to get the name of every disk item of this_folder
end tell
set new_file to file_name & file_ext
set x to 1
repeat
    if new_file is in file_list then
        set new_file to file_name & " " & x & file_ext
        set x to x + 1
    else
        exit repeat
    end if
end repeat

-- create and select the new file
tell application "Finder"
    activate
    set the_file to make new file at folder this_folder with properties {name:new_file}
    if is_desktop is false then
        reveal the_file
    else
        select window of desktop
        set selection to the_file
        delay 0.1
    end if
end tell

-- press enter (rename)
tell application "System Events"
    tell process "Finder"
        keystroke return
    end tell
end tell
