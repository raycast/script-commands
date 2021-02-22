#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open directory in VSCode
# @raycast.mode silent
# @raycast.packageName Developer Utilities
#
# Optional parameters:
# @raycast.icon images/vscode.png
#
# Documentation:
# @raycast.description Opens current topmost directory in VSCode
# @raycast.author chohner
# @raycast.authorURL https://github.com/chohner

tell application "Finder"
    set pathList to (quoted form of POSIX path of (folder of the front window as alias))
end tell

do shell script "/usr/local/bin/code " & pathList
