#!/bin/bash
# Compatible: Bash 3.2+ (macOS default)

# @raycast.schemaVersion 1
# @raycast.title Launch AI Terminal
# @raycast.mode silent
# @raycast.packageName AI Development
# @raycast.icon 🚀
# @raycast.iconColor "#7C3AED"
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select AI Tool", "data": [{"title": "🤖 Claude Code", "value": "claude"}, {"title": "⚡ Codex", "value": "codex"}, {"title": "🌟 Gemini", "value": "gemini"}, {"title": "🌙 Kimi", "value": "kimi"}, {"title": "🖥️  Standard", "value": "standard"}] }
# @raycast.description Launch Ghostty terminal with AI-specific visual themes
# @raycast.author David (drg)

# ============================================================
# Load shared helpers + find Ghostty binary
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/ghostty.sh
source "$SCRIPT_DIR/lib/ghostty.sh"
GHOSTTY="$(find_ghostty)" || exit 1

# ============================================================
# Validate argument
# ============================================================
TOOL="$1"
case "${TOOL}" in
    claude|codex|gemini|kimi|standard) ;;
    *)
        echo "❌ Invalid tool: ${TOOL}" >&2
        echo "💡 Valid options: claude, codex, gemini, kimi, standard" >&2
        exit 1
        ;;
esac

# ============================================================
# Launch Ghostty with selected AI theme
# ============================================================
case "${TOOL}" in
    claude)
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
        ;;
    codex)
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
        ;;
    gemini)
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
        ;;
    kimi)
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
        ;;
    standard)
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
        ;;
esac

exit 0
