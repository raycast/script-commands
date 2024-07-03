#!/bin/bash

# Note: ChatGPT for macOS required
# Download it via OpenAI website: https://openai.com/chatgpt/mac/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open ChatGPT
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description It opens the macOS ChatGPT app if it's not running already. If it's already running, then it just invokes the ChatGPT via the `⌥+Space` hotkey. ⚠️ Note: Please assign this script the `⌥+Space` hotkey in Raycast for this to work as expected.
# @raycast.author luiscarlospando
# @raycast.authorURL https://raycast.com/luiscarlospando

APP_NAME="ChatGPT"

if pgrep -x "$APP_NAME" > /dev/null
then
    exit 0
else
    open -a "$APP_NAME"
fi
