#!/bin/bash

# Inspired by https://twitter.com/year_progress

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Year Progress
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon ⏱
# @raycast.packageName Dashboard

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description See the year progress on your desktop.


# Configuration

OUTPUT_INCLUDES_BAR=true
BAR_LENGTH=33


# Main program

current_year=$(date +%Y)
current_day=$(date +%j)

if [ $((current_year % 400)) -eq 0 ]
then
  DAYS=366
elif [ $((current_year % 100)) -eq 0 ]
then
  DAYS=365
elif [ $((current_year % 4)) -eq 0 ]
then
  DAYS=366
else
  DAYS=365
fi

percentage=$((100 * 10#$current_day / $DAYS))

filled_element_count=$(($BAR_LENGTH * $percentage / 100))
blank_element_count=$(($BAR_LENGTH - $filled_element_count))
bar=""
for ((i = 0; i < $filled_element_count; i++)) {
  bar=${bar}"▓"
}
for ((i = 0; i < $blank_element_count; i++)) {
  bar=${bar}"░"
}

if [ "$OUTPUT_INCLUDES_BAR" = true ]
then
  echo ${bar}" "${percentage}"%"
else 
  echo ${percentage}"%"
fi