#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SABnzbd Queue
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Dashboard

# Documentation:
# @raycast.description Show SABnzbd's queue status
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

protocol="http"
address="127.0.0.1"
port="8080"
apikey="<-- API KEY -->"

full_queue_status=$(curl -s "$protocol://$address:$port/sabnzbd/api?output=json&apikey=$apikey&mode=queue")

status=$(echo "$full_queue_status" | jq -j '.queue.status')
size_left=$(echo "$full_queue_status" | jq -j '.queue.sizeleft')
size=$(echo "$full_queue_status" | jq -j '.queue.size')
speed=$(echo "$full_queue_status" | jq -j '.queue.speed')
time_left=$(echo "$full_queue_status" | jq -j '.queue.timeleft')
no_of_slots=$(echo "$full_queue_status" | jq -j '.queue.noofslots')

if [ "$status" = "Paused" ]; then
  time_left="-"
  speed="-"
fi

echo "🚦 $status ・ 📥 $no_of_slots ・ ⏳ $time_left ・ 💿 $size_left / $size ・ 📊 $speed"
