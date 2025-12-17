#!/bin/bash
# Shared helpers for Ghostty Raycast scripts
# Compatible: Bash 3.2+ (macOS default)

find_ghostty() {
  local SEARCH_PATHS=(
    "/Applications/Ghostty.app/Contents/MacOS/ghostty"
    "/opt/homebrew/bin/ghostty"
    "/usr/local/bin/ghostty"
    "$HOME/.local/bin/ghostty"
  )

  local p
  for p in "${SEARCH_PATHS[@]}"; do
    if [ -x "$p" ]; then
      echo "$p"
      return 0
    fi
  done

  p="$(command -v ghostty 2>/dev/null)"
  if [ -n "$p" ] && [ -x "$p" ]; then
    echo "$p"
    return 0
  fi

  echo "❌ Ghostty not found" >&2
  echo "💡 Install: brew install ghostty" >&2
  return 1
}
