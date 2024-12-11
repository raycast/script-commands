#!/bin/bash

# Note: lowfi and WezTerm required
#
# Install lowfi at https://github.com/talwat/lowfi
# or by cargo: cargo install lowfi
#
# Install WezTerm at https://wezfurlong.org/wezterm/install/macos.html
# or by homebrew: brew install --cask wezterm

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lowfi
# @raycast.mode compact
# @raycast.packageName Music

# Optional parameters:
# @raycast.icon

export PATH="$HOME/.cargo/bin:$PATH"

# Check if lowfi is already running
if pgrep -f "lowfi$" > /dev/null; then
    echo "Found existing lowfi process"

    # Use AppleScript to find and focus the lowfi window
    osascript -e '
        -- First activate WezTerm application
        tell application "WezTerm" to activate
        
        -- Then focus the specific window
        tell application "System Events"
            tell process "wezterm-gui"
                -- Get all windows
                set allWindows to every window
                repeat with w in allWindows
                    if title of w contains "lowfi" then
                        -- Try multiple methods to bring window to front
                        set frontmost to true
                        set value of attribute "AXMain" of w to true
                        perform action "AXRaise" of w
                        set position of w to {0, 40}
                        -- Click the window to ensure focus
                        click w
                        return "Found and focused lowfi window"
                    end if
                end repeat
            end tell
        end tell
        return "Could not find lowfi window"
    '
else
    echo "Starting new lowfi instance"
    /Applications/WezTerm.app/Contents/MacOS/wezterm start -- lowfi &
fi
