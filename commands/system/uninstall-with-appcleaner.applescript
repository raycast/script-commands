#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Uninstall with AppCleaner
# @raycast.mode silent
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "Application", "optional": false }
#
# Optional parameters:
# @raycast.icon 🗑
#
# Documentation:
# @raycast.description Uninstall applications with AppCleaner
# @raycast.author Felipe Turcheti
# @raycast.authorURL https://felipeturcheti.com

on run {appName}
  set bundleId to id of application appName
  tell application "Finder"
    set appPath to (POSIX path of (application file id bundleId as alias))
    do shell script "open -a AppCleaner \"" & appPath & "\""
    log "Opening \"" & appName & "\" in AppCleaner…"
  end tell
end run
