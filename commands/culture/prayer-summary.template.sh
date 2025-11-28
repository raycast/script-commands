#!/bin/bash

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set your city and country below.
# Optionally, adjust the calculation method to fit your location.
#
# API: https://aladhan.com/prayer-times-api

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prayer Summary
# @raycast.mode inline
# @raycast.refreshTime 2m

# Optional parameters:
# @raycast.icon 🕌
# @raycast.packageName Culture

# Documentation:
# @raycast.description Get the current and next prayer times for a specific city and country.
# @raycast.author Muneeb Ajaz
# @raycast.authorURL https://github.com/mianmuneebajaz


# Configuration

# Set your city and country below:
# 1. Replace CITY with your city name (e.g., "London")
# 2. Replace COUNTRY with your country name (e.g., "United Kingdom")
CITY=""
COUNTRY=""

# Calculation method (default: 3 for Muslim World League - MWL)
# Common methods:
# 1 - University of Islamic Sciences, Karachi
# 2 - Islamic Society of North America (ISNA)
# 3 - Muslim World League (MWL)
# 4 - Umm Al-Qura University, Makkah
# 5 - Egyptian General Authority of Survey
# See https://aladhan.com/prayer-times-api for all methods
METHOD="3"


# Main program

if ! command -v jq &> /dev/null; then
  echo "jq is required (https://stedolan.github.io/jq/)"
  exit 1
fi

if [ -z "$CITY" ] || [ -z "$COUNTRY" ]; then
  echo "City and Country are required"
  exit 1
fi

DATA=$(curl -s -L "http://api.aladhan.com/v1/timingsByCity?city=${CITY}&country=${COUNTRY}&method=${METHOD}")

if [ -z "$DATA" ]; then
  echo "Unable to fetch prayer times"
  exit 1
fi

get_time() {
  echo "$DATA" | jq -r ".data.timings.$1"
}

FAJR=$(get_time "Fajr")
DHUHR=$(get_time "Dhuhr")
ASR=$(get_time "Asr")
MAGHRIB=$(get_time "Maghrib")
ISHA=$(get_time "Isha")

# Convert 24h to 12h format
to_ampm() {
  date -j -f "%H:%M" "$1" "+%I:%M %p" 2>/dev/null
}

PRAYER_NAMES=("Fajr" "Dhuhr" "Asr" "Maghrib" "Isha")
PRAYER_TIMES=("$FAJR" "$DHUHR" "$ASR" "$MAGHRIB" "$ISHA")

epoch_today() {
  date -j -f "%Y-%m-%d %H:%M" "$(date +%Y-%m-%d) $1" "+%s"
}

NOW=$(date +%s)

CURRENT="None (before Fajr)"
NEXT=""
NEXT_TIME=""
NEXT_EPOCH=0
LAST=""

for i in "${!PRAYER_NAMES[@]}"; do
  name="${PRAYER_NAMES[$i]}"
  time="${PRAYER_TIMES[$i]}"
  ep=$(epoch_today "$time")

  if [ "$ep" -le "$NOW" ]; then
    LAST="$name"
  elif [ -z "$NEXT" ]; then
    NEXT="$name"
    NEXT_TIME="$time"
    NEXT_EPOCH="$ep"
  fi
done

if [ -n "$LAST" ]; then
  CURRENT="$LAST"
fi

# After Isha, next prayer is tomorrow's Fajr
if [ -z "$NEXT" ]; then
  NEXT="Fajr (tomorrow)"
  NEXT_TIME="$FAJR"
  NEXT_EPOCH=$(($(epoch_today "$FAJR") + 86400))
fi

DIFF=$((NEXT_EPOCH - NOW))
H=$((DIFF / 3600))
M=$(((DIFF % 3600) / 60))
COUNTDOWN="${H}h ${M}m"

NEXT_AM=$(to_ampm "$NEXT_TIME")

echo "Current: $CURRENT | Next: $NEXT at $NEXT_AM in $COUNTDOWN"
