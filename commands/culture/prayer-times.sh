#!/bin/bash
set -euo pipefail

# Prayer Times Fetcher - Raycast Script
# Fetches Islamic prayer times from aladhan.com API with caching support
# Compatible with Bash 3.2+ (macOS default)
#
# Requirements:
#   - curl: for API requests
#   - jq: for JSON parsing
#   - date/gdate: for time calculations
#
# macOS users: Install coreutils for gdate support:
#   brew install coreutils jq

# Raycast metadata
# @raycast.schemaVersion 1
# @raycast.title Prayer Times
# @raycast.mode inline
# @raycast.packageName Culture
# @raycast.icon mosque.png
# @raycast.author Emircan Erkul
# @raycast.authorURL https://emircanerkul.com
# @raycast.description Prayer times grabbed from aladhan.com

# Configuration
CITY="${PRAYER_CITY:-derince}"
COUNTRY="${PRAYER_COUNTRY:-turkey}"
METHOD="${PRAYER_METHOD:-13}"
CACHE_TTL="${PRAYER_CACHE_TTL:-3600}"

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
CACHE_FILE="${CACHE_DIR}/prayer-times/prayer-times-${CITY}-${COUNTRY}.json"

# Prayer times stored as individual variables (Bash 3.2 compatible)
IMSAK=""
SUNRISE=""
DHUHR=""
ASR=""
MAGHRIB=""
ISHA=""

# Detect date command
detect_date_cmd() {
    if command -v gdate &>/dev/null; then
        echo "gdate"
    elif date -d "today" +%s &>/dev/null 2>&1; then
        echo "date"
    else
        echo "Error: Install GNU coreutils: brew install coreutils" >&2
        exit 1
    fi
}

# Initialize cache directory
init_cache() {
    mkdir -p "${CACHE_DIR}/prayer-times" 2>/dev/null || true
}

# Check if cache is valid
is_cache_valid() {
    local cache_file="$1"
    local ttl="$2"
    local date_cmd="$3"
    
    [[ ! -f "$cache_file" ]] && return 1
    
    local cache_mtime now
    cache_mtime=$($date_cmd -r "$cache_file" +%s 2>/dev/null) || return 1
    now=$($date_cmd +%s)
    
    local age=$((now - cache_mtime))
    ((age < ttl))
}

# Validate cached data matches today
is_valid_data() {
    local data="$1"
    local date_cmd="$2"
    
    [[ -z "$data" ]] && return 1
    ! echo "$data" | jq -e '.data.timings' &>/dev/null && return 1
    
    local cached_date today
    cached_date=$(echo "$data" | jq -r '.data.date.gregorian.date' 2>/dev/null) || return 1
    today=$($date_cmd +%d-%m-%Y 2>/dev/null) || return 1
    
    [[ "$cached_date" == "$today" ]]
}

# Fetch from API
fetch_prayer_times() {
    local api_url="http://api.aladhan.com/v1/timingsByCity?city=${CITY}&country=${COUNTRY}&method=${METHOD}"
    curl -s -L --max-time 10 "$api_url" 2>/dev/null
}

# Load prayer times from JSON into variables
load_prayer_times() {
    local data="$1"
    IMSAK=$(echo "$data" | jq -r '.data.timings.Imsak')
    SUNRISE=$(echo "$data" | jq -r '.data.timings.Sunrise')
    DHUHR=$(echo "$data" | jq -r '.data.timings.Dhuhr')
    ASR=$(echo "$data" | jq -r '.data.timings.Asr')
    MAGHRIB=$(echo "$data" | jq -r '.data.timings.Maghrib')
    ISHA=$(echo "$data" | jq -r '.data.timings.Isha')
}

# Convert time to seconds
time_to_seconds() {
    local time_str="$1"
    local date_cmd="$2"
    $date_cmd -d "$time_str" +%s 2>/dev/null
}

# Format remaining time
format_remaining() {
    local seconds="$1"
    local hours=$((seconds / 3600))
    local mins=$(((seconds / 60) % 60))
    local secs=$((seconds % 60))
    
    if ((hours > 0)); then
        echo "${hours}h ${mins}m ${secs}s"
    elif ((mins > 0)); then
        echo "${mins}m ${secs}s"
    else
        echo "${secs}s"
    fi
}

# Find next prayer
find_next_prayer() {
    local now="$1"
    local date_cmd="$2"
    
    local prayers=("$IMSAK" "$SUNRISE" "$DHUHR" "$ASR" "$MAGHRIB" "$ISHA")
    local names=("Imsak" "Sunrise" "Dhuhr" "Asr" "Maghrib" "Isha")
    
    local next_prayer=""
    local next_time=""
    local min_diff=-1
    local i=0
    
    for time in "${prayers[@]}"; do
        local prayer_seconds diff
        prayer_seconds=$(time_to_seconds "$time" "$date_cmd") || continue
        diff=$((prayer_seconds - now))
        
        if ((diff > 0)); then
            if ((min_diff == -1 || diff < min_diff)); then
                min_diff=$diff
                next_prayer="${names[$i]}"
                next_time="$time"
            fi
        fi
        ((i++))
    done
    
    # If no upcoming prayer, next is Imsak tomorrow
    if [[ -z "$next_prayer" ]]; then
        local tomorrow_seconds
        tomorrow_seconds=$(time_to_seconds "tomorrow $IMSAK" "$date_cmd") || return
        min_diff=$((tomorrow_seconds - now))
        next_prayer="Imsak"
        next_time="$IMSAK"
    fi
    
    echo "$next_prayer|$next_time|$min_diff"
}

# Main
main() {
    if ! command -v jq &>/dev/null; then
        echo "Error: jq required. Install: brew install jq" >&2
        exit 1
    fi
    
    local date_cmd
    date_cmd=$(detect_date_cmd)
    
    init_cache
    
    local data=""
    
    # Try valid cache first
    if is_cache_valid "$CACHE_FILE" "$CACHE_TTL" "$date_cmd"; then
        data=$(cat "$CACHE_FILE" 2>/dev/null)
        if ! is_valid_data "$data" "$date_cmd"; then
            data=""
        fi
    fi
    
    # Try API if no valid cache
    if [[ -z "$data" ]]; then
        data=$(fetch_prayer_times) || data=""
        if [[ -n "$data" ]] && is_valid_data "$data" "$date_cmd"; then
            echo "$data" > "$CACHE_FILE" 2>/dev/null || true
        fi
    fi
    
    # Fallback to stale cache
    if [[ -z "$data" && -f "$CACHE_FILE" ]]; then
        data=$(cat "$CACHE_FILE" 2>/dev/null)
        if ! is_valid_data "$data" "$date_cmd"; then
            data=""
        fi
    fi
    
    if [[ -z "$data" ]]; then
        echo "Error: No prayer times available" >&2
        exit 1
    fi
    
    # Load times into variables
    load_prayer_times "$data"
    
    # Calculate
    local now
    now=$($date_cmd +%s)
    
    local next_info
    next_info=$(find_next_prayer "$now" "$date_cmd") || exit 1
    
    local next_prayer next_time remaining_seconds
    IFS='|' read -r next_prayer next_time remaining_seconds <<< "$next_info"
    
    local remaining_str
    remaining_str=$(format_remaining "$remaining_seconds")
    
    # Output
    echo "☾ ${remaining_str} ☽ $IMSAK ⚙︎ $SUNRISE ⚙︎ $DHUHR ⚙︎ $ASR ⚙︎ $MAGHRIB ⚙︎ $ISHA"
}

main "$@"
