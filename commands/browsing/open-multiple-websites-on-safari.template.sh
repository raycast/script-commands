#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Multiple Websites on Safari
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📚
# @raycast.packageName Browsing

# Documentation:
# @raycast.description Open multiple websites on Safari using list of URLs
# @raycast.author Yasutaka Nishii
# @raycast.authorURL https://github.com/ystknsh

# Set list of URLs
urls=(
    "https://example.com"
    "https://example.org"
    "https://example.net"
    "https://example.jp"
    "https://example.io"
    "https://example.ai"
)

# Make AppleScript commands 
applescript_command="tell application \"Safari\"
    make new document with properties {URL:\"${urls[0]}\"}
    tell window 1"

for ((i=1; i<${#urls[@]}; i++)); do
    applescript_command+="
        make new tab with properties {URL:\"${urls[$i]}\"}"
done

applescript_command+="
    end tell
end tell"

# Execute AppleScript
osascript -e "$applescript_command"

# Set Safari window to front（Optional）
osascript <<EOD
tell application "System Events"
    tell process "Safari"
        set frontmost to true
        tell window 1
            set value of attribute "AXMain" to true
            set value of attribute "AXFocused" to true
        end tell
    end tell
end tell
EOD