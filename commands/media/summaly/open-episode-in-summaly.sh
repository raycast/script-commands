#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Open Episode in Summaly
# @raycast.mode silent
# @raycast.packageName Summaly
# @raycast.icon 🎧
# @raycast.argument1 { "type": "text", "placeholder": "Apple Podcasts or YouTube link" }
# @raycast.description Bring an episode to Summaly to review its length and credits before summarizing.
# @raycast.author Huaxin Wang
# @raycast.authorURL https://github.com/WilsonWang01

target=
url=${1%%#*}
apple='^https://podcasts\.apple\.com/([a-z]{2})/podcast/([^/?#[:space:]]+/)?id([0-9]{1,20})/?\?([^#[:space:]]+)$'
episode='(^|&)i=([0-9]{1,20})(&|$)'
watch='^https://((www|m)\.)?youtube\.com/watch\?([^#[:space:]]+)$'
video='(^|&)v=([A-Za-z0-9_-]{11})(&|$)'
short='^https://(youtu\.be/|((www|m)\.)?youtube\.com/(shorts|live|embed)/)([A-Za-z0-9_-]{11})/?(\?[^[:space:]]*)?$'

if [[ $url =~ $apple ]]; then
  store=${BASH_REMATCH[1]}
  slug=${BASH_REMATCH[2]%/}
  show=${BASH_REMATCH[3]}
  query=${BASH_REMATCH[4]}
  if ! [[ $slug =~ ^[a-zA-Z0-9_~%-]{1,240}$ ]]; then slug=episode; fi
  if [[ $query =~ $episode ]]; then
    target="apple/$store/$show/${BASH_REMATCH[2]}/$slug"
  fi
elif [[ $url =~ $watch ]]; then
  query=${BASH_REMATCH[3]}
  if [[ $query =~ $video ]]; then
    target="youtube/${BASH_REMATCH[2]}"
  fi
elif [[ $url =~ $short ]]; then
  target="youtube/${BASH_REMATCH[5]}"
fi

if [[ -z ${target:-} ]]; then
  echo "Paste an individual Apple Podcasts episode or YouTube video link."
  exit 1
fi

open "https://summaly.online/en/podcast/open-episode#$target"
