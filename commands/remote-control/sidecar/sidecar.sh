#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sidecar
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.packageName untraceablez.sidecar
# @raycast.argument1 { "type": "text", "placeholder": "iPad Name" }
# Documentation:
# @raycast.description Use Apple Sidecar to extend your Mac display to  iPad.
# @raycast.author untraceablez
# @raycast.authorURL https://raycast.com/untraceablez

# Set the IPADNAME variable to the first argument
IPADNAME=$1

# Run the AppleScript, passing the IPADNAME variable
osascript <<EOF
tell application "System Settings"
    activate
    reveal pane id "com.apple.Displays-Settings.extension"
end tell

tell application "System Events"
    tell process "System Settings"
        delay 3 -- Wait for UI to be ready

        -- Retry checking for the Displays window up to 5 times
        set windowReady to false
        repeat 6 times
            if exists window "Displays" then
                set windowReady to true
                exit repeat
            else
                delay 1 -- Wait before checking again
            end if
        end repeat

        -- If the Displays window is still not available, show an error
        if not windowReady then
            display dialog "Error: The Displays window is not available in System Settings." buttons {"OK"} default button "OK"
            return
        end if

        -- Target the "Add" button
        try
            tell pop up button "Add" of group 1 of group 2 of splitter group 1 of group 1 of window "Displays"
                click
                repeat until exists of menu "Add"
                    delay 0.2
                end repeat

                set ipadName to "$IPADNAME" as text
                
                -- Check if the iPad name is listed
                if (count of (get menu items of menu "Add" whose name contains ipadName)) = 0 then
                    -- Create a dialog with a button to open the documentation
                    set doc_response to display dialog "iPad not appearing in Display menu." buttons {"OK", "Sidecar Docs"} default button "OK"
                    
                    if button returned of doc_response is "Sidecar Docs" then
                        open location "https://support.apple.com/guide/mac-help/use-your-ipad-as-a-second-display-mchlf3c6f7ae/mac"
                    end if
                    
                    return
                end if

                -- Click the appropriate menu item
                click (last menu item of menu "Add" whose name contains ipadName)
            end tell
            
        on error errMsg -- Catch any errors that occur within the try block
            display dialog "An error occurred: " & errMsg buttons {"OK"} default button "OK"
            return
        end try
    end tell
end tell
EOF

