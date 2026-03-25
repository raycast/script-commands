#!/usr/bin/osascript

# Install Tomighty via https://tomighty.org/mac/
# or from Github Releases: https://github.com/tomighty/tomighty-osx/releases

# @raycast.title Stop Pomodoro
# @raycast.author Marc Ignacio
# @raycast.authorURL https://github.com/padi
# @raycast.description Stop Pomodoro via Tomighty's default hotkey

# @raycast.icon images/tomighty.png
# @raycast.mode silent
# @raycast.packageName Tomighty
# @raycast.schemaVersion 1

# tomightyIsRunning should have a PID if running or  "" if not running
set tomightyIsRunning to (do shell script "pgrep Tomighty || true")

if tomightyIsRunning is not "" then
  tell application "System Events"
    # Press the defaut hotkey for "Stop Pomodoro"
    keystroke "s" using {control down, command down}
  end tell

  log "Stopped Pomodoro"
else
  log "Tomighty is not running. Start a pomodoro first"
  # Play subtle Basso sound
  # afplay is a built-in, native command-line utility in macOS
  do shell script "afplay /System/Library/Sounds/Basso.aiff"
end if
