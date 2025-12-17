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
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Launch Ghostty with Standard theme
# ============================================================
"$GHOSTTY" \
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
    > /dev/null 2>&1 &
exit 0
