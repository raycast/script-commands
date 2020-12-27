#!/usr/bin/osascript

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Dark Mode Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/dark-mode-toggle.png

tell application "System Events"

    tell appearance preferences

        set dark mode to not dark mode

    end tell

end tell