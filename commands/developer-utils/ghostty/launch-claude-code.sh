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
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Launch Ghostty with Claude Code theme
# ============================================================
"$GHOSTTY" \
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
    > /dev/null 2>&1 &
exit 0
