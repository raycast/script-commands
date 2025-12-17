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
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Launch Ghostty with Gemini theme
# ============================================================
"$GHOSTTY" \
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
    > /dev/null 2>&1 &
exit 0
