#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title QR Code Reader/Generator
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Generate a QR code from your current clipboard string
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://qrcode?clipboard
