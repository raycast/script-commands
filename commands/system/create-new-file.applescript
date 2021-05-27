#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create New File
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📄

# @Documentation:
# @raycast.description Create files in the front window or desktop of the visit
# @raycast.author LokHsu
# @raycast.authorURL https://github.com/lokhsu

set file_name to "untitled"
set file_ext to ".txt"
set is_desktop to false

-- get folder path
try
    tell application "Finder"
        set this_folder to folder of the front window as alias
    end tell
on error   -- no open folder windows
    set this_folder to path to desktop folder as alias
    set is_desktop to true
end try

-- get the new file name (do not override an already existing file)
tell application "Finder"
    set file_list to name of every file of this_folder
end tell

set new_file to file_name & file_ext
set x to 1

repeat
    if new_file is in file_list then
        set new_file to file_name & x & file_ext
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
