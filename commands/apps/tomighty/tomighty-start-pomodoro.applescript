#!/usr/bin/osascript

# Install Tomighty via https://tomighty.org/mac/
# or from Github Releases: https://github.com/tomighty/tomighty-osx/releases

# @raycast.title Start Pomodoro
# @raycast.author Marc Ignacio
# @raycast.authorURL https://github.com/padi
# @raycast.description Start Pomodoro via Tomighty's default hotkey

# @raycast.icon images/tomighty.png
# @raycast.mode silent
# @raycast.packageName Tomighty
# @raycast.schemaVersion 1

# Start Tomighty automatically, bring it to the foreground
tell application "Tomighty" to activate

tell application "System Events"
  # Wait for activity...
  repeat until exists process "Tomighty"
    delay 0.2
  end repeat

  # Press the defaut hotkey for "Start Pomodoro"
  keystroke "p" using {control down, command down}
  log "Started Pomodoro"
end tell
