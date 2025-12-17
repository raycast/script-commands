#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Kimi Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon 🌙
# @raycast.iconColor "#A78BFA"
# @raycast.description Launch Ghostty terminal for Kimi CLI
# @raycast.author David (drg)

# ============================================================
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Launch Ghostty with Kimi theme (Dark Side of the Moon)
# ============================================================
"$GHOSTTY" \
    --title="🌙 Kimi" \
    --background="#0F1419" \
    --foreground="#C9D1D9" \
    --cursor-style=block_hollow \
    --cursor-color="#A78BFA" \
    --window-padding-x=18 \
    --window-padding-y=14 \
    --font-size=13.5 \
    --background-opacity=1.0 \
    --background-blur-radius=0 \
    --selection-background="#1F2937" \
    --selection-foreground="#E5E7EB" \
    > /dev/null 2>&1 &
exit 0
