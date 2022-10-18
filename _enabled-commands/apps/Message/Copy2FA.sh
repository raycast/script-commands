#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Code
# @raycast.mode silent
# @raycast.packageName Messages

# Optional parameters:
# @raycast.icon images/Message.png

# Documentation:
# @raycast.description Copy 2FA verification code from messages.
# @raycast.authorURL https://github.com/tesles. Adapted from Fatpandac's script command "Copy Code" (https://github.com/Fatpandac)

USERNAME=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
# H/T to Armin Briegel (https://scriptingosx.com/2020/02/getting-the-current-user-in-macos-update/) for the above code by way of Erik Berglund (https://erikberglund.github.io/2018/Get-the-currently-logged-in-user,-in-Bash/)

result=$(sqlite3 /Users/$USERNAME/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

# Append or remove synonyms for "code" into keyword list as needed to generate support for additional languages.
keyword=("code");
keyword_regex="^(.*)(${keyword[*]\/%\/|})(.*)$"

if [[ ! "$result" ]]; then
  echo "No 2FA code found!"
  exit 0;
fi

if [[ "$result" =~ $keyword_regex ]]; then
  code=$(echo "$result" | grep -o "[0-9]\{4,6\}");

  echo "$code" | pbcopy;
  echo "2FA code from Messages: $code"
fi
