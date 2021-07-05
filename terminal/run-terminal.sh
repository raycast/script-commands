#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run terminal
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "command" }

#!/bin/sh
osascript <<END
tell application "Terminal"
    do script "$1"
end tell
END
