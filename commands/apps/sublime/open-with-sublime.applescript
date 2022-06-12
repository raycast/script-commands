#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open with Sublime
# @raycast.mode silent

# Optional parameters:
# @raycast.icon https://cdn.worldvectorlogo.com/logos/sublime-text.svg
# @raycast.packageName Sublime

# Documentation:
# @raycast.author Rock Hu
# @raycast.authorURL https://twitter.com/0xRock
# @raycast.description Open currently focused directory in Sublime

set targetApp to path to application "Sublime Text"

tell application "Finder"
    set theSelection to selection
    if theSelection is {} then
        if exists Finder window 1 then
            set currentDir to target of Finder window 1 as alias
            open currentDir using targetApp
        end if
    else
        open theSelection using targetApp
    end if
end tell