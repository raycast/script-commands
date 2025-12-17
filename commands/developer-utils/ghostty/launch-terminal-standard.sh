#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Standard Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon 🖥️
# @raycast.iconColor "#BD93F9"
# @raycast.description Launch Ghostty terminal with standard theme
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
# Launch Ghostty with Standard theme
# ============================================================
open -na Ghostty.app --args \
    --title="🖥️  Standard" \
    --background="#282A36" \
    --foreground="#C5AED6" \
    --cursor-style=block \
    --cursor-color="#BD93F9" \
    --window-padding-x=18 \
    --window-padding-y=14 \
    --font-size=14 \
    --background-opacity=1.0 \
    --background-blur-radius=0 \
    --selection-background="#3D3A4F" \
    --selection-foreground="#F0E6FF" \
    > /dev/null 2>&1

exit 0
