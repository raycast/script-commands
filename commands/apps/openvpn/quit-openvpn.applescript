#!/usr/bin/osascript

# Note: OpenVPN v3.3+ recommended
# Install via https://openvpn.net/vpn-client/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit OpenVPN
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/openvpn.png
# @raycast.packageName OpenVPN
#
# Documentation:
# @raycast.description Quits the OpenVPN Connect client.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

-- shouldn't try to quit if app isn't running, but sometimes we do silly things ;)
if application "OpenVPN Connect" is running then
  -- no op
else
  return "OpenVPN Connect not running"
end if

ignoring application responses --removes 5 sec delay (via caching?)
  tell application "System Events" to tell process "OpenVPN Connect" to click menu bar item 1 of menu bar 2
end ignoring
delay 0.1
do shell script "killall System\\ Events"

tell application "System Events" to tell process "OpenVPN Connect" to tell menu bar item 1 of menu bar 2
  click
  get menu items of menu 1
  click menu item "Exit" of menu 1
  do shell script "echo OpenVPN exited"
end tell

