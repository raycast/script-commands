#!/usr/bin/osascript

# @raycast.title Hate Current Track
# @raycast.author Bryan Schuetz
# @raycast.authorURL https://github.com/bryanschuetz
# @raycast.description Let the algorithm know how you feel about the currently playing track.
# @raycast.icon images/apple-music-logo.png
# @raycast.placeholder Hate it 
# @raycast.mode silent
# @raycast.packageName Apple Music
# @raycast.schemaVersion 1
  tell application "Music"
    set disliked of current track to true
    log "Litterally, the worst."
  end tell