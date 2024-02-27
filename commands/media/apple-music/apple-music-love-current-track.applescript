#!/usr/bin/osascript

# @raycast.title Love Current Track
# @raycast.author Bryan Schuetz
# @raycast.authorURL https://github.com/bryanschuetz
# @raycast.description Let the algorithm know how you feel about the currently playing track.
# @raycast.icon images/apple-music-logo.png
# @raycast.placeholder Love It <3
# @raycast.mode silent
# @raycast.packageName Apple Music
# @raycast.schemaVersion 1

  tell application "Music"
    if player state is playing then
        set favorited of current track to true
        log "<3 Yeah, the song is now favorited"
    else
        return "No track is currently playing."
    end if
  end tell
