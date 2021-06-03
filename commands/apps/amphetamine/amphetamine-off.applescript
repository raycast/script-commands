#!/usr/bin/osascript

# Install Amphetamine via Mac App Store: https://apps.apple.com/us/app/amphetamine/id937984704

# @raycast.title End Session
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons
# @raycast.description Stop Current Amphetamine Session

# @raycast.icon images/amphetamine.png
# @raycast.mode silent
# @raycast.packageName Amphetamine
# @raycast.schemaVersion 1

tell application "Amphetamine" to end session

log "Ended current session"
