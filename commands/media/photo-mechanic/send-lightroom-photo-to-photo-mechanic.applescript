#!/usr/bin/osascript

# Note: Requires Adobe Lightroom Classic (cloud Lightroom is not supported)
# Install via Adobe Creative Cloud: https://www.adobe.com/products/photoshop-lightroom-classic.html

# Note: Requires Photo Mechanic Plus, Photo Mechanic 6, or Photo Mechanic (legacy)
# Install via Camera Bits: https://home.camerabits.com

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Send Lightroom Photo to Photo Mechanic
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📸
# @raycast.packageName Photo Mechanic

# Documentation:
# @raycast.description Reveals the active Lightroom Classic photo in Photo Mechanic — equivalent to dragging the file onto Photo Mechanic's icon. Useful for photojournalists who cull or caption in Photo Mechanic but edit in Lightroom Classic.
# @raycast.author dustchambers
# @raycast.authorURL https://github.com/dustchambers

on run
    -- Lightroom Classic only; cloud Lightroom has no AppleScript interface
    set lrBundle to "com.adobe.LightroomClassicCC7"
    set lrRunning to false
    try
        tell application "System Events"
            set lrRunning to (count of (processes whose bundle identifier is lrBundle)) > 0
        end tell
    end try
    if not lrRunning then
        display notification "Lightroom Classic isn't running. Note: cloud Lightroom is not supported." with title "LR → Photo Mechanic"
        return
    end if

    tell application id lrBundle to activate
    delay 0.25

    -- Trigger Library > Show in Finder (⌘R) to reveal the active photo
    tell application "System Events"
        keystroke "r" using command down
    end tell
    delay 0.7

    -- Read the revealed file path from Finder
    set thePath to ""
    try
        tell application "Finder"
            set theSel to selection
            if theSel is {} then error "No photo selected, or original is offline."
            set thePath to POSIX path of ((item 1 of theSel) as alias)
        end tell
    on error errMsg
        display notification errMsg with title "LR → Photo Mechanic"
        return
    end try

    -- Verify the file is readable (catches offline network drives and missing originals)
    try
        do shell script "test -r " & quoted form of thePath
    on error
        display notification "File not readable — check if the drive is mounted: " & thePath with title "LR → Photo Mechanic"
        return
    end try

    -- Hand off to Photo Mechanic by bundle ID (replicates drag-onto-icon behavior)
    set pmBundles to {"com.camerabits.PhotoMechanicPlus", "com.camerabits.PhotoMechanic"}
    set launched to false
    repeat with bid in pmBundles
        try
            do shell script "open -b " & quoted form of bid & " " & quoted form of thePath
            set launched to true
            exit repeat
        end try
    end repeat
    if not launched then
        display notification "Photo Mechanic isn't installed." with title "LR → Photo Mechanic"
    end if
end run
