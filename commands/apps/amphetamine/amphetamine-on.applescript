#!/usr/bin/osascript

# Install Amphetamine via Mac App Store: https://apps.apple.com/us/app/amphetamine/id937984704

# @raycast.title Start Default Session
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons
# @raycast.description Start Default Amphetamine Session

# @raycast.icon images/amphetamine.png
# @raycast.mode silent
# @raycast.packageName Amphetamine
# @raycast.schemaVersion 1

tell application "Amphetamine" to start new session

log "Started default session"
