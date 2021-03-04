#!/usr/bin/osascript

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename,
# Replace all instances of <display> with the name of your monitor.
#     Monitor name can be seen by open System Preferences → Display,
#         and look at the window's title name. example: DELL P2212H.
# Replace all instances of <degree> to 90, 180 or 270

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Flip Screen <display> to <degree>°
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥

# @Documentation:
# @raycast.description Toggle flip (rotate) or revert the <display> to <degree>°
# @raycast.author Yohanes Bandung Bondowoso
# @raycast.authorURL https://github.com/ybbond

use scripting additions

set displayName to "<display>"
set targetDegree to "<degree>°"

if running of application "System Preferences" then
  quit application "System Preferences"
end if

tell application "System Preferences"
  activate
  reveal anchor "displaysDisplayTab" of pane id "com.apple.preference.displays"
end tell

tell application "System Events" to tell process "System Preferences"
  set currentCount to 0
  repeat while currentCount < 5
    if exists tab group 1 of window displayName then
      set currentCount to 5
    else
      delay 0.5
      set currentCount to currentCount + 1
    end if
  end repeat

  try
    tell window displayName
      if exists pop up button 2 of tab group 1 then
        tell pop up button 2 of tab group 1
          if (value) contains "Standard" then
            set currentAction to "Flipping"
            click
            click menu item targetDegree of menu 1
          else
            set currentAction to "Reverting"
            click
            click menu item "Standard" of menu 1
          end if
        end tell
      else
        tell pop up button 1 of tab group 1
          if (value) contains "Standard" then
            set currentAction to "Flipping"
            click
            click menu item targetDegree of menu 1
          else
            set currentAction to "Reverting"
            click
            click menu item "Standard" of menu 1
          end if
        end tell
      end if
    end tell
  on error errString
    log "Some error, please contact me so I can try to fix :)"
  end try
end tell

log currentAction & space & "display succeed"

tell application "System Preferences"
  quit
end tell

tell application "System Events"
  quit
end tell