#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title JustFocus
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/justfocus.png
# @raycast.argument1 { "type": "text", "placeholder": "po,sb,lb,stop" }

# Documentation:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz

on run argv
    set q to item 1 of argv
    if ((q as string) is equal to "po") then
        tell application "JustFocus"
            launch
            start pomodoro
        end tell
    else if ((q as string) is equal to "sb") then
        tell application "JustFocus"
            launch
            short break
        end tell
    else if ((q as string) is equal to "lb") then
        tell application "JustFocus"
            launch
            long break
        end tell
    else if ((q as string) is equal to "stop") then
        tell application "JustFocus"
            stop
        end tell
    end if
end run
