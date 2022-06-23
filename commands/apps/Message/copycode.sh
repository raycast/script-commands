#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Code
# @raycast.mode silent
# @raycast.packageName Messages

# Optional parameters:
# @raycast.icon images/Message.png

# Documentation:
# @raycast.description Copy verification code from a message.
# @raycast.author Fatpandac
# @raycast.authorURL https://github.com/Fatpandac

USERNAME=$(id -u -n)

result=$(sqlite3 /Users/$USERNAME/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

#You can append another `keyword` into the list to support other language Messages.
keyword=("验证码" "code");
keyword_regex="^(.*)(${keyword[*]/%/|})(.*)$"

if [ ! $result ]; then
  echo "No verification code received in the last 60 seconds!"
  exit 0;
fi

if [[ "$result" =~ "$keyword_regex" ]]; then
  code=`echo $result | grep -o "[0-9]\{4,6\}"`;

  echo "$code" | pbcopy;
  echo "$code code copied!"
fi

