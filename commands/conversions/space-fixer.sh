#!/usr/bin/env bash

# Add spaces between Chinese and English, number or symbols.
#
# Dependency: This script requires the `https://www.npmjs.com/package/pangu` package.
# Install it via `pip install pangu` or `pnpm install -g pangu` or `npm install -g pangu`.
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Space Fixer
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝
# @raycast.packageName Conversions

# Documentation:
# @raycast.description Add spaces between Chinese and English, number or symbols.
# @raycast.author RealTong
# @raycast.authorURL https://raycast.com/RealTong

pangu_path="/Users/realtong/Library/pnpm/pangu"

if [ -z "$pangu_path" ]; then
  echo "Error: pangu not found in PATH"
  exit 1
fi

input=$(pbpaste)

if [ -z "$input" ]; then
  echo "Input is empty"
  exit 1
fi

# 调用 pangu ： pangu -t "text"

output=$($pangu_path -t "$input")
if [ -z "$output" ]; then
  echo "Output is empty"
  exit 1
fi

echo $output | pbcopy
echo "Fixed Chinese text has been copied to the clipboard"
