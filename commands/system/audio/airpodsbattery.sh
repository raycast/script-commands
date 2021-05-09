#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AirPods Battery Level
# @raycast.mode inline

# Optional parameters:
# @raycast.icon ⚡️
# @raycast.packageName Audio
# @raycast.refreshTime 10m

# Documentation:
# @raycast.description Get the current battery status of your AirPods.
# @raycast.author Quentin Eude
# @raycast.authorURL https://www.github.com/qeude

# This should be changed every time new AirPods models are released.
airpods_product_ids=("0x200E" "0x200F" "0x2002")
airpods_max_product_ids=("0x200A")

system_profiler=$(system_profiler SPBluetoothDataType 2>/dev/null)
mac_addr=$(grep -b2 "Minor Type: Headphones"<<<"${system_profiler}"|awk '/Address/{print $3}')
connected=$(grep -ia11 "${mac_addr}"<<<"${system_profiler}"|awk '/Connected: Yes/{print 1}')
product_id=$(grep -ia11 "${mac_addr}"<<<"${system_profiler}"|awk '/Product ID/{print $3}')
delimiter="    🎧    "

function join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }


if [[ "${connected}" ]]; then
    if [[ " ${airpods_product_ids[*]} " =~ ${product_id} ]]; then
        battery_infos=("BatteryPercentCase,Case" "BatteryPercentLeft,Left" "BatteryPercentRight,Right")
        declare -a result_array
        for i in "${battery_infos[@]}"; do
            key=${i%,*};
            val=${i#*,};
            battery_level=$(defaults read /Library/Preferences/com.apple.Bluetooth    | grep "$key" | tr -d \; | awk '{print $3}')
            # Not displaying info when battery level is 0% since it means not connected for the system
            # When batteries are empty, the device will stay at 1%
            if [[ $battery_level == 0 ]]; then
                continue
            fi
            result_array+=("$val $battery_level%")
        done
        join_by "$delimiter" "${result_array[@]}"
        exit 0
    elif [[ " ${airpods_max_product_ids[*]} " =~ ${product_id} ]]; then
        battery_single=$(defaults read /Library/Preferences/com.apple.Bluetooth    | grep BatteryPercentSingle | tr -d \; | awk '{print $3}')
        echo "🎧 $battery_single%"
        exit 0
    else
        echo "No AirPods connected. 🤷"
        exit 0
    fi
else
    echo "No AirPods connected. 🤷"
    exit 0
fi
