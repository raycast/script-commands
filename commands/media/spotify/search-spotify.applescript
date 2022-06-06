#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Spotify
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/spotify-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.packageName Search on Spotify Desktop App

# Documentation:
# @raycast.description Search a given query on the Spotify Desktop App
# @raycast.author Marcos Rios
# @raycast.authorURL https://github.com/marcoslor

on run argv

    try 
        if application "Spotify" is not running then
            activate application "Spotify"
            delay 1

            set screenElementsCount to 0
            set loopCount to 0
            
            # Verify whether the splash screen is gone by checking
            # if the count of the UI elements on the window is above a certain threshold.

            repeat while (screenElementsCount < 6 and loopCount <= 20)
                tell application "System Events"
                    tell front window of application process "Spotify"
                        set screenElementsCount to count (entire contents as list)
                    end tell
                end tell
                set loopCount to loopCount + 1
                delay 0.5
            end repeat

            if loopCount > 20
                error "asserting the app has been opened took too long"
            end if

            # Randomly assigned delay based on trial and error on my machine.

            # Obiviously, this won't work for everyone, and I have NO IDEA how to 
            # verify whether Spotify is initiated and ready to receive inputs.

            delay 3
        end if

        if application "Spotify" is running then
            tell application "System Events" to tell process "Spotify"
                click menu item "Search" of menu 1 of menu bar item "Edit" of menu bar 1

                set frontmost to true

                delay 0.5
                keystroke ( item 1 of argv )
            end tell
        else
            error
        end if
        
    on error errMsg
        if contents of errMsg is not ""
            log "Failed to open Spotify: " & errMsg 
        else
            log "Failed to open Spotify"
        end if
    end try
    
end run