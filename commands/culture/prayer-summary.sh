#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prayer Summary
# @raycast.description Get the prayer times for the current day
# @raycast.mode inline
# @raycast.refreshTime 2m

# Optional parameters:
# @raycast.icon 🕌

CITY="Lahore"
COUNTRY="Pakistan"
METHOD=13

DATA=$(curl -s -L "http://api.aladhan.com/v1/timingsByCity?city=$CITY&country=$COUNTRY&method=$METHOD")

if [ -z "$DATA" ]; then
  echo "⚠️ Error: Unable to fetch prayer times"
  exit 0
fi

get_time() {
  echo "$DATA" | jq -r ".data.timings.$1"
}

FAJR=$(get_time Fajr)
DHUHR=$(get_time Dhuhr)
ASR=$(get_time Asr)
MAGHRIB=$(get_time Maghrib)
ISHA=$(get_time Isha)

# Convert 24h → 12h format
to_ampm() {
  date -j -f "%H:%M" "$1" "+%I:%M %p" 2>/dev/null
}

FAJR_AM=$(to_ampm "$FAJR")
DHUHR_AM=$(to_ampm "$DHUHR")
ASR_AM=$(to_ampm "$ASR")
MAGHRIB_AM=$(to_ampm "$MAGHRIB")
ISHA_AM=$(to_ampm "$ISHA")

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

  if [ $ep -le $NOW ]; then
    LAST=$name
  elif [ -z "$NEXT" ]; then
    NEXT=$name
    NEXT_TIME=$time
    NEXT_EPOCH=$ep
  fi
done

if [ -n "$LAST" ]; then
  CURRENT="$LAST"
fi

# After Isha → next is tomorrow Fajr
if [ -z "$NEXT" ]; then
  NEXT="Fajr (tomorrow)"
  NEXT_TIME="$FAJR"
  NEXT_EPOCH=$(( $(epoch_today "$FAJR") + 86400 ))
fi 

DIFF=$(( NEXT_EPOCH - NOW ))
H=$(( DIFF / 3600 ))
M=$(( (DIFF % 3600) / 60 ))
COUNTDOWN="${H}h ${M}m"

NEXT_AM=$(to_ampm "$NEXT_TIME")

# ANSI color codes
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RESET=$'\033[0m'

# Color code current prayer (green)
CURRENT_DISPLAY="${GREEN}${CURRENT}${RESET}"

# Color code countdown yellow if less than 10 minutes
if [ $DIFF -lt 600 ]; then
  COUNTDOWN_DISPLAY="${YELLOW}${COUNTDOWN}${RESET}"
else
  COUNTDOWN_DISPLAY="$COUNTDOWN"
fi

echo "Current: $CURRENT_DISPLAY | Next: $NEXT at $NEXT_AM in $COUNTDOWN_DISPLAY"
