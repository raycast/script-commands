#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Gemini Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon 🌟
# @raycast.iconColor "#4285F4"
# @raycast.description Launch Ghostty terminal for Gemini
# @raycast.author David (drg)

# ============================================================
# Find Ghostty binary
# ============================================================
find_ghostty() {
    local SEARCH_PATHS=(
        "/Applications/Ghostty.app/Contents/MacOS/ghostty"
        "/opt/homebrew/bin/ghostty"
        "/usr/local/bin/ghostty"
        "$HOME/.local/bin/ghostty"
    )

    local path
    for path in "${SEARCH_PATHS[@]}"; do
        if [ -x "$path" ]; then
            echo "$path"
            return 0
        fi
    done

    local path_result
    path_result=$(command -v ghostty 2>/dev/null)
    if [ -n "$path_result" ] && [ -x "$path_result" ]; then
        echo "$path_result"
        return 0
    fi

    echo "❌ Ghostty not found" >&2
    echo "💡 Install: brew install ghostty" >&2
    return 1
}

find_ghostty || exit 1

# ============================================================
# Launch Ghostty with Gemini theme
# ============================================================
open -na Ghostty.app --args \
    --title="🌟 Gemini" \
    --background="#1A1F2E" \
    --foreground="#8BABCC" \
    --cursor-style=underline \
    --cursor-color="#4285F4" \
    --window-padding-x=24 \
    --window-padding-y=20 \
    --font-size=14 \
    --background-opacity=0.96 \
    --background-blur-radius=4 \
    --selection-background="#2B3547" \
    --selection-foreground="#D4E3F0" \
    > /dev/null 2>&1

exit 0
