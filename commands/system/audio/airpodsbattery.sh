#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Airpods Battery
# @raycast.mode inline

# Optional parameters:
# @raycast.icon ⚡️
# @raycast.packageName Audio
# @raycast.refreshTime 10m

# Documentation:
# @raycast.description Get the current battery status of your Airpods.
# @raycast.author Quentin Eude
# @raycast.authorURL https://www.github.com/qeude

OUTPUT=''
BLUETOOTH_DEFAULTS=$(defaults read /Library/Preferences/com.apple.Bluetooth)
SYSTEM_PROFILER=$(system_profiler SPBluetoothDataType 2>/dev/null)
MAC_ADDR=$(grep -b2 "Minor Type: Headphones"<<<"${SYSTEM_PROFILER}"|awk '/Address/{print $3}')
CONNECTED=$(grep -ia6 "${MAC_ADDR}"<<<"${SYSTEM_PROFILER}"|awk '/Connected: Yes/{print 1}')
BLUETOOTH_DATA=$(grep -ia6 '"'"${MAC_ADDR}"'"'<<<"${BLUETOOTH_DEFAULTS}")
BATTERY_LEVELS=("BatteryPercentCombined" "HeadsetBattery" "BatteryPercentSingle" "BatteryPercentCase" "BatteryPercentLeft" "BatteryPercentRight")
LAST=${BATTERY_LEVELS[${#BATTERY_LEVELS[@]} - 1]}

if [[ "${CONNECTED}" ]]; then
    for I in "${BATTERY_LEVELS[@]}"; do
        declare -x "${I}"="$(awk -v pat="${I}" '$0~pat{gsub (";",""); print $3 }'<<<"${BLUETOOTH_DATA}")"
        if [[ $I == "BatteryPercentCase" && ${!I} == 0 ]]; then
            continue
        fi
        if [[ $I == $LAST ]]; then
            [[ -n "${!I}" ]] && OUTPUT="${OUTPUT} $(awk '/BatteryPercent/{print substr($0,15,5)}'<<<"${I}") ${!I}%"
        else
            [[ -n "${!I}" ]] && OUTPUT="${OUTPUT} $(awk '/BatteryPercent/{print substr($0,15,5)}'<<<"${I}") ${!I}% | "
        fi
    done
    echo "${OUTPUT}"
    exit 0
else
    echo "Not connected"
    exit 0
fi
