#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Current Track
# @raycast.mode inline
# @raycast.refreshTime 10s
#
# @raycast.icon ℹ️
# @raycast.packageName Cmus
#
# @raycast.description Shows info on the current track if cmus is running
# @raycast.author mmerle
# @raycast.authorURL https://github.com/mmerle
#
# Modified script from https://github.com/Anachron/i3blocks/blob/master/blocks/cmus


cmus-remote >& /dev/null
if [[ $? -eq 0 ]]; then
  info_cmus=$(cmus-remote -Q)
  info_status=$(echo "${info_cmus}" | sed -n -e 's/^.*status//p' | head -n 1)
  track_title=$(echo "${info_cmus}" | sed -n -e 's/^.*title//p' | head -n 1)
  track_artist=$(echo "${info_cmus}" | sed -n -e 's/^.*artist//p' | head -n 1)
  track_album=$(echo "${info_cmus}" | sed -n -e 's/^.*album//p' | head -n 1)
    if [[ $info_status == *"playing"* ]]; then
        out_text="${track_title} —${track_artist}"
    else
        out_text="[PAUSED] ${track_title} —${track_artist}"
    fi
else
  out_text="Cmus is not running"
fi

echo ${out_text}
