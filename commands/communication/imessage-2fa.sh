#!/bin/bash

### Requires Raycast to have Full Disk Access:
### https://spin.atomicobject.com/2020/05/22/search-imessage-sql/

## Contributions welcome to improve regular expressions.

# @raycast.title 2FA from iMessages
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda
# @raycast.description Get most recent two-factor authentication code from iMessages.

# @raycast.icon 🔐
# @raycast.mode silent
# @raycast.packageName iMessage
# @raycast.schemaVersion 1

sqlite_path="$HOME/Library/Messages/chat.db"
regex="(^| |\s|\t|\R|G-|:)([0-9]{5,8})"
query=" 
    select
        message.rowid,
        ifnull(handle.uncanonicalized_id, chat.chat_identifier) AS sender,
        message.service,
        datetime(message.date / 1000000000 + 978307200, 'unixepoch', 'localtime') AS message_date,
        message.text
    from
        message
            left join chat_message_join
                on chat_message_join.message_id = message.ROWID
            left join chat
                on chat.ROWID = chat_message_join.chat_id
            left join handle
                on message.handle_id = handle.ROWID
    where
        is_from_me = 0
        and text is not null
        and length(text) > 0
        and (
            text glob '*[0-9][0-9][0-9][0-9][0-9]*'
            or text glob '*[0-9][0-9][0-9][0-9][0-9][0-9]*'
            or text glob '*[0-9][0-9][0-9][0-9][0-9][0-9][0-9]*'
            or text glob '*[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]*'
        )
    order by
        message.date desc
    limit 50
"

while read -r line; do  
    IFS='|' 
    read -a columns <<< "${line}"

    id=${columns[0]}
    sender=${columns[1]}
    date=${columns[3]}
    message=${columns[4]}

    if [[ $message =~ $regex ]]; then
        matchedCode="${BASH_REMATCH[2]}"
        echo $matchedCode | pbcopy 
        echo "Copied \"$matchedCode\" from $sender on $date"
        exit
    fi
done <<< "$(sqlite3 $sqlite_path "$query")"

echo 'No two factor authentication codes found'