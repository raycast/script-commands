#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Reload CoreAudio
# @raycast.mode silent
# @raycast.author Maxim Krouk
# @raycast.authorURL https://github.com/maximkrouk
# @raycast.description Reloads CoreAudio.
# @raycast.icon 🎧
# @raycast.packageName System

sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod
echo "Done"

