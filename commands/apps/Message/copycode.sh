#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CopyCode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/Message.png

# Documentation:
# @raycast.description Copy code from chinese message.
# @raycast.author Fatpandac
# @raycast.authorURL https://github.com/Fatpandac

USERNAME=$(id -u -n)

result=$(sqlite3 /Users/$USERNAME/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

keyword="验证码";

if [ ! $result ]; then
  echo "最近60秒未收到验证码！"
  exit 0;
fi

if [[ "$result" =~ "$keyword" ]]; then
  code=`echo $result | grep -o "[0-9]\{4,6\}"`;

  echo "$code" | pbcopy;
  echo "$code 验证码已复制"
fi

