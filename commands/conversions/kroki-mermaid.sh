#!/bin/bash


# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title My First Script
# @raycast.mode sildent
# @raycast.packageName Raycast Scripts
#
# Optional parameters:
# @raycast.icon 🤖
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Send Mermaid diagram to Kroki Diagram Generator
# @raycast.author Bill Zhong
# @raycast.authorURL https://github.com/zmx

open -u `pbpaste | python3 -c "import sys; import base64; import zlib; print('https://kroki.io/mermaid/svg/' + base64.urlsafe_b64encode(zlib.compress(sys.stdin.read().encode('utf-8'), 9)).decode('ascii'))"`