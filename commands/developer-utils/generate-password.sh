#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Password
# @raycast.mode silent

# Optional parameters:
# @raycast.author Sven Hofmann
# @raycast.authorURL https://github.com/hofmannsven
# @raycast.description Generates a random password and copies it to the clipboard.
# @raycast.icon 🔐

gpg --gen-random -a 0 30 | pbcopy
echo "Password Generated"
