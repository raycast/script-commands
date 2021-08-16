#!/usr/bin/osascript

# Note: OpenVPN v3.3+ recommended
# Install via https://openvpn.net/vpn-client/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect OpenVPN
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/openvpn.png
# @raycast.packageName OpenVPN
#
# Documentation:
# @raycast.description Prepares OpenVPN Connect client to connect or reconnect.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

if application "OpenVPN Connect" is running then
  -- no op
else
  tell application "OpenVPN Connect" to activate
  delay 3 --wait for init
end if

ignoring application responses --removes 5 sec delay (via caching?)
  tell application "System Events" to tell process "OpenVPN Connect" to click menu bar item 1 of menu bar 2
end ignoring
delay 0.1
do shell script "killall System\\ Events"

tell application "System Events" to tell process "OpenVPN Connect" to tell menu bar item 1 of menu bar 2
  click
  get menu items of menu 1
  try
    click menu item "Connect" of menu 1
    do shell script "echo OpenVPN ready to connect"
  on error --menu item toggles between connect/disconnect
    key code 53 --escape key to close menu
    do shell script "echo Already connected"
  end try
end tell
