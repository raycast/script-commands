#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Codex Reset Forecast
# @raycast.mode inline
# @raycast.refreshTime 10m
# @raycast.packageName Dashboard

# Optional parameters:
# @raycast.icon 🔄
# @raycast.author codex-reset.com
# @raycast.authorURL https://github.com/suvadadepolo-blip
# @raycast.description Chance that OpenAI resets Codex usage limits in the next 24/48 hours, and days since the last confirmed reset. Free public API, no key. Data: codex-reset.com

# Global early resets only; your own 5-hour/weekly window is shown by /status in Codex.
# JSON is read with macOS's built-in plutil, so no jq is needed.

UA="raycast-codex-reset/1.0 (+https://github.com/raycast/script-commands)"
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

if ! curl -fsS --max-time 10 -A "$UA" "https://codex-reset.com/api/forecast" -o "$tmp"; then
  echo "codex-reset.com unreachable"
  exit 1
fi

get() { plutil -extract "$1" raw -o - "$tmp" 2>/dev/null; }

p24=$(get probabilities.rounded_24h)
p48=$(get probabilities.rounded_48h)
age=$(get age_days)

line="${p24:-?}% in 24h · ${p48:-?}% in 48h"
[ -n "$age" ] && line="$line · last reset ${age%%.*}d ago"
if [ "$(plutil -type official_signal "$tmp" 2>/dev/null)" = "dictionary" ]; then
  line="$line · official signal active"
fi
echo "$line"
