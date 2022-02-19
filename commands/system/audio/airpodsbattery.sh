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
airpods_product_ids=("0x200E" "0x200F" "0x2002" "0x2013")
airpods_max_product_ids=("0x200A")
delimiter="    🎧    "

function join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }

system_profiler=$(system_profiler SPBluetoothDataType 2>/dev/null)
mac_addresses=($(grep -b2 "Minor Type: Headphones"<<<"${system_profiler}" | awk '/Address/{print $3}'))
airpods_list=()
for i in "${mac_addresses[@]}"; do
    mac_address_system_profiler=$(grep -ia11 "${i}"<<<"${system_profiler}")
    # $(grep -ia11 "${mac_addr}"<<<"${system_profiler}"|awk '/Product ID/{print $3}')
    product_id=$(echo "$mac_address_system_profiler" | awk '/Product ID/{print $3}')
    if [[ ! "${airpods_product_ids[*]}" =~ $product_id && ! "${airpods_max_product_ids[*]}" =~ $product_id ]]; then
        continue
    fi
    airpods_list+=("$i,$product_id,$(echo "$mac_address_system_profiler" | awk '{if ($0 ~ /Connected: Yes/) {print 1} else if ($0 ~ /Connected: No/) {print 0}}')")
done

if [[ "${airpods_list[*]}" =~ ",1" ]]; then
    # Started here, we are going to assume that we only take the first connected AirPods
    mac_address=${airpods_list[0]%,*,*}
    temp=${airpods_list[0]#*,*}
    product_id=${temp%*,*}
    default=$(grep -ia6 '"'"${mac_address}"'"'<<<"$(defaults read /Library/Preferences/com.apple.Bluetooth)")
    if [[ "${airpods_product_ids[*]}" =~ $product_id ]]; then
        battery_infos=("BatteryPercentCase,Case" "BatteryPercentLeft,Left" "BatteryPercentRight,Right")
        declare -a result_array
        for i in "${battery_infos[@]}"; do
            key=${i%,*};
            val=${i#*,};
            battery_level=$(echo "$default" | grep "$key" | tr -d \; | awk '{print $3}')
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
        battery_single=$(echo "$default" | grep BatteryPercentSingle | tr -d \; | awk '{print $3}')
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
