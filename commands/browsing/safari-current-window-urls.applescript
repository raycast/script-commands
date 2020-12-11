#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Window URLs
# @raycast.mode silent
# @raycast.packageName Safari
#
# Optional parameters:
# @raycast.icon 🧭
#
# Documentation:
# @raycast.description This script copies to clipboard all URLs from frontmost Safari window.
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

tell application "Safari"
    tell front window
        if its document exists then
            set AppleScript's text item delimiters to linefeed
            set urlList to URL of its tabs
            set the clipboard to (urlList as text)
            log "Copied"
        end if
    end tell
end tell
