#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Low Power Mode
# @raycast.mode silent

# @raycast.icon 🔋
# @raycast.author Kailash Yellareddy
# @raycast.authorURL https://github.com/kyellareddy

on getLowPowerMode(str)
    set trimmedStr to do shell script "echo " & quoted form of str & " | xargs" -- trim trailing spaces
    set lastChar to character (length of trimmedStr) of trimmedStr -- get last character
    set mode to lastChar as number -- convert to number
    return mode
end getLowPowerMode
tell application "System Settings"
    set output to do shell script "pmset -g | grep lowpowermode" 
end tell
set result to getLowPowerMode(output)
if result = 0 then
    tell application "System Settings"
        do shell script "pmset -a lowpowermode 1" with administrator privileges
    end tell
    do shell script "echo Low Power Mode turned on."
else
    tell application "System Settings"
        do shell script "pmset -a lowpowermode 0" with administrator privileges
    end tell

# This makes the brightness 100% again, if it doesn't go all the way to 100% for you, change the number of times it repeats.
    repeat 25 times
        tell application "System Events"
            key code 144
        end tell
    end repeat
end if
