#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Youtube Shorts in video player
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📹

# Documentation:
# @raycast.description Opens current Youtube Shorts video in the normal video player by replacing "/shorts/" with "/v/" in the url.
# @raycast.author Kailash Yellareddy
# @raycast.authorURL https://github.com/kyellareddy

# -------------------------------------------------------------------
# |  # This script currently supports Safari and Google Chrome.      |
# |  # Replace "Safari" in line 21 with either "Safari" or "Chrome"  |
# -------------------------------------------------------------------

set browser to "Safari"


if browser="Safari"
    tell application "Safari"
        tell front window
            if its document exists then
			     set CurrentUrl to URL of current tab
		    end if
        end tell
    end tell

    set inputText to CurrentUrl
    set findText to "shorts"
    set replaceText to "v"

    set newText to do shell script "sed 's|" & quoted form of findText & "|" & quoted form of replaceText & "|g' <<< " & quoted form of inputText

    tell application "Safari"
        tell window 1
            tell current tab
                set URL to {newText}
            end tell
        end tell
    end tell
end if

if browser="Chrome"
    tell application "Google Chrome"
    set frontIndex to active tab index of front window
    get URL of tab frontIndex of front window
        set CurrentUrl to URL of tab frontIndex of front window
    end tell

    set inputText to CurrentUrl
    set findText to "shorts"
    set replaceText to "v"

     set newText to do shell script "sed 's|" & quoted form of findText & "|" & quoted form of replaceText & "|g' <<< " & quoted form of inputText

     tell application "Google Chrome"
        set URL of active tab of window 1 to {newText}
    end tell
end if
