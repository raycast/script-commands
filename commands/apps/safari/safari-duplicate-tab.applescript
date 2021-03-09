#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Duplicate Tab
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon images/safari.png

# @Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Duplicates and opens the currently active tab.

tell window 1 of application "Safari"
  set currentURL to get URL of current tab
  set newTab to make new tab with properties { URL: currentURL }
  set current tab to newTab
end