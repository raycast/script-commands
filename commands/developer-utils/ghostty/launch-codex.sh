#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Codex Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon ⚡
# @raycast.iconColor "#10A37F"
# @raycast.description Launch Ghostty terminal for Codex
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
# Launch Ghostty with Codex theme
# ============================================================
open -na Ghostty.app --args \
    --title="⚡ Codex" \
    --background="#1A1D21" \
    --foreground="#7DB8A8" \
    --cursor-style=bar \
    --cursor-color="#10A37F" \
    --window-padding-x=16 \
    --window-padding-y=12 \
    --font-size=13 \
    --background-opacity=1.0 \
    --background-blur-radius=0 \
    --selection-background="#243B35" \
    --selection-foreground="#C2E5DB" \
    > /dev/null 2>&1

exit 0
