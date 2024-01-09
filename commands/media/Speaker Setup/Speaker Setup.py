#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Speaker Setup
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔊

# Documentation:
# @raycast.author Kailash Yellareddy
# @raycast.authorURL https://github.com/kyellareddy

# SETUP:
# There are two audio files that are needed for this script to work
# Left.mp3 and Right.mp3
# Replace "<file path for left channel>" with the file path to Left.mp3
# Replace <file path for right channel> with the file path for Right.mp3
# Install  the playsound package from https://pypi.org/project/playsound/

from playsound import playsound

playsound('<file path for left channel>')

playsound('<file path for right channel>')
