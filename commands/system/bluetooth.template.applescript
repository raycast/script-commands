#!/usr/bin/osascript

# @raycast.title Toggle Bluetooth
# @raycast.author Vincent Dörig
# @raycast.authorURL https://github.com/vincentdoerig
# @raycast.description Toggle your Bluetooth connection.

# @raycast.icon images/bluetooth.png
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

# set this variable to the equivalent of "Control Center" in your system language
set ControlCenterWindow to "Control Center"

tell application "System Events"
  tell process "ControlCenter"
    click menu bar item "Bluetooth" of menu bar 1
    set BluetoothSwitch to checkbox "Bluetooth" of group 1 of window ControlCenterWindow
    click BluetoothSwitch
    delay 1
    if value of BluetoothSwitch is 0 then
      do shell script "echo Bluetooth turned off"
    else
      do shell script "echo Bluetooth turned on"
    end if
  end tell
end tell
