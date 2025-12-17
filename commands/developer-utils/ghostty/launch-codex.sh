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
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Launch Ghostty with Codex theme
# ============================================================
"$GHOSTTY" \
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
    > /dev/null 2>&1 &
exit 0
