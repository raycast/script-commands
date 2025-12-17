#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Claude Code Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon 🤖
# @raycast.iconColor "#5865F2"
# @raycast.description Launch Ghostty terminal for Claude Code
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
# Launch Ghostty with Claude Code theme
# ============================================================
open -na Ghostty.app --args \
    --title="🤖 Claude Code" \
    --background="#1E1E2E" \
    --foreground="#D4A574" \
    --cursor-style=block \
    --cursor-color="#5865F2" \
    --window-padding-x=20 \
    --window-padding-y=16 \
    --font-size=13.5 \
    --background-opacity=0.98 \
    --background-blur-radius=2 \
    --selection-background="#3A2F47" \
    --selection-foreground="#F2E5D7" \
    > /dev/null 2>&1

exit 0
