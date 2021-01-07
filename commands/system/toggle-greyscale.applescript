#!/usr/bin/osascript

# @raycast.title Toggle Greyscale
# @raycast.author Matthew Alp
# @raycast.authorURL https://github.com/MattAlp
# @raycast.description Toggle system greyscale through automation

# @raycast.mode silent
# Optional parameters:
# @raycast.icon 🔘
# @raycast.packageName System
# @raycast.schemaVersion 1

tell application "System Preferences"
    activate
    set the current pane to pane id "com.apple.preference.universalaccess"
    delay 1 #needs time to open universal access
    tell application "System Events" to tell process "System Preferences" to tell window "Accessibility"
        select row 5 of table 1 of scroll area 1 #open display preferences
        click radio button "Color Filters" of tab group 1 of group 1
        click checkbox "Enable Color Filters" of tab group 1 of group 1
    end tell
end tell
tell application "System Preferences" to quit