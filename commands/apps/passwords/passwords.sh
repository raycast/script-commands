#!/usr/bin/env bash

# Quickly open iCloud Keychain passwords
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title open passwords
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/passwords.png
# @raycast.packageName Passwords

# Documentation:
# @raycast.description Quickly open iCloud Keychain passwords
# @raycast.author RealTong
# @raycast.authorURL https://raycast.com/RealTong

open "x-apple.systempreferences:com.apple.Passwords"
