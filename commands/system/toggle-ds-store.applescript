#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle .DS_Store
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🧬
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit
# @raycast.description A script command to enable and disable .DS_Store


try
	set ToggleDSStore to do shell script "defaults read com.apple.desktopservices"
on error
	set ToggleDSStore to "1"
end try

if ToggleDSStore is "1" then
	do shell script "defaults write com.apple.desktopservices DSDontWriteNetworkStores true"
  set DSStoreStatus to ".DS_Store Deactivated"
else
  do shell script "defaults delete com.apple.desktopservices DSDontWriteNetworkStores"
  set DSStoreStatus to ".DS_Store Activated"
end if

DSStoreStatus
