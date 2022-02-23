#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Fear Index
# @raycast.mode inline
# @raycast.refreshTime 12h

# Optional parameters:
# @raycast.packageName Fear & Greed Index
# @raycast.icon 😱 

# Documentation:
# @raycast.description Fear & Greed Index from CNN
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit

url="https://money.cnn.com/data/fear-and-greed/"
result=$(curl -s $url )

result=$(echo "$result" | sed -e 's/(Fear)/↓/g')
result=$(echo "$result" | sed -e 's/(Greed)/↑/g')

greedNow=$(echo "$result" | sed -n -e 's/.*<li>Fear &amp; Greed Now: *\([^<]*\).*/\1/p')
greedPrevious=$(echo "$result" | sed -n -e 's/.*<li>Fear &amp; Greed Previous Close: *\([^<]*\).*/\1/p')
greedWeek=$(echo "$result" | sed -n -e 's/.*<li>Fear &amp; Greed 1 Week Ago: *\([^<]*\).*/\1/p')
greedMonth=$(echo "$result" | sed -n -e 's/.*<li>Fear &amp; Greed 1 Month Ago: *\([^<]*\).*/\1/p')
greedYear=$(echo "$result" | sed -n -e 's/.*<li>Fear &amp; Greed 1 Year Ago: *\([^<]*\).*/\1/p')

echo "H:$greedNow   D:$greedPrevious   W:$greedWeek   M:$greedMonth   Y:$greedYear"
