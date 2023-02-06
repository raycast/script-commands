#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tesla
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🚘

# Documentation:
# @raycast.description Get the status of your Tesla vehicle
# @raycast.author Mortada Sarheed
# @raycast.authorURL https://github.com/mSarheed

### SETUP ###
## Get your token ##
# On iOS you can use the app Auth app for Tesla link: https://apps.apple.com/us/app/auth-app-for-tesla/id1552058613
# On Android you can use the app Tesla Tokens link: https://play.google.com/store/apps/details?id=net.leveugle.teslatokens&hl=en&gl=US
# Retrieve your refresh token and paste it into the varibale $refresh token

# ONLY relevant if you have multiple Tesla Vehicles and on the same Tesla Account. 
#If you have multiple Tesla Vehicles, please identify the ID of your vehicle. You can use this tool https://tesla-info.com/tesla-token.php to get the vehicle ID
 
refresh_token=''

url="https://tesla-info.com/api/control_v2.php?refresh=$refresh_token&request=get_data"

data=$(curl -s "$url")

# Name of vehicle
name=$(echo $data | grep -o '"display_name":"[^"]*"' | awk -F':' '{print $2}' | tr -d '"')

# State
state=$(echo $data | grep -o '"state":[^,]*' | awk -F':' '{print $2}' | tr -d '"')
# Uppercase first letter
state="$(tr '[:lower:]' '[:upper:]' <<< ${state:0:1})${state:1}"
if [ "$state" == "Online" ]; then
    state="\033[32m$state\033[0m ✅"
else
    state="\033[31m$state\033[0m 💤"
fi

# Vehicle locked or not
locked=$(echo $data | grep -o '"locked":[^,]*' | awk -F':' '{print $2}' | tr -d '"')
locked=$(echo $locked | tr -d ' ')

if [ "$locked" = true ]; then
    locked="\033[32mLocked\033[0m"
else
    locked="\033[31mUnlocked\033[0m"
fi

# Sentry mode
sentry=$(echo $data | grep -o '"dashcam_state":"[^"]*"' | awk -F':' '{print $2}' | tr -d '"')

if [ "$sentry" == "Recording" ]; then
    sentry="\033[31mRecording\033[0m"
else
    sentry="\033[32mOff\033[0m"
fi

battery_level=$(echo $data | grep -o '"battery_level":[^,]*' | awk -F':' '{print $2}' | tr -d '"')

est_battery_range=$(echo $data | grep -o '"est_battery_range":[^,]*' | awk -F':' '{print $2}' | tr -d '"')
# Tesla shows the battery range estimate miles. If you need to show this in kilometeres instead, just uncomment the line below
est_battery_range=$(echo "$est_battery_range * 1.60934" |  bc)
# Limit kilometers to no decimals
est_battery_range=$(printf "%.0f\n" "$est_battery_range")

charging_state=$(echo $data | grep -o '"charging_state":"[^"]*"' | awk -F':' '{print $2}' | tr -d '"')

minutes_to_full_charge=$(echo $data | grep -o '"minutes_to_full_charge":[^,]*' | awk -F':' '{print $2}' | tr -d '"')

charge_limit=$(echo $data | grep -o '"charge_limit_soc":[^,]*' | awk -F':' '{print $2}' | tr -d '"')

if [ "$name" == "" ]; then
    echo -e "⚠️ \033[31mSORRY! - Something went wrong.\033[0m ⚠️"
    echo -e ''
    echo -e "\033[31mEither a bad token or the API service is down!\033[0m"
else
    echo -e "🚘 Status of: \033[34m$name\033[0m 🚘"
    echo ''

    echo -e "➡️ Vehicle State: $state"
    echo ''

    echo -e "➡️ Doors: $locked 🔐"
    echo ''

    echo -e "➡️ Sentry: $sentry 📸"
    echo ''

    echo -e "➡️ Battery: \033[34m$battery_level%\033[0m 🔋"
    echo ''

    echo -e "➡️ Est. range: \033[34m$est_battery_range km\033[0m 🛣️"
    echo ''

    if [ "$charging_state" == "Charging" ]; then
        echo -e "➡️ SoC Limit: \033[34m$charge_limit%\033[0m ⚡️"
        echo ''
        echo -e "➡️ Time left to charge limit: \033[34m$minutes_to_full_charge minutes\033[0m ⏰"
    else
        echo -e "➡️ Charging state: \033[31mNot charging\033[0m 🔌"
    fi
fi