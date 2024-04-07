#!/bin/bash

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
# 1. Download the files Left.mp3 and Right.mp3
# 2. Replace "Left.mp3" in line 21 with the file path for the file Left.mp3
# 3. Replace "Right.mp3" in line 24 with the file path for the file Right.mp3

# Play the first audio file
afplay Left.mp3

# Play the second audio file
afplay Right.mp3
