#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Status
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 📶

# @Documentation:
# @raycast.packageName System
# @raycast.description Get current network connections.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti

function get_wifi_ssid () {
  service_info=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport --getinfo)
  ssid_line=$(echo "$service_info" | grep -v "BSSID" | grep "SSID")
  ssid=$(echo "$ssid_line" | awk -F "(: )" '{print $2}')

  echo "$ssid"
}

function get_internet_status () {
  if ! ping -q -c 2 google.com &>/dev/null; then
    echo " (No Internet)"
  fi
}

current_device=$(route get default 2>/dev/null | grep "interface" | awk '{print $2}')

# Exit if there's no connection
if [ -z "$current_device" ]; then
  echo "No connection"
  exit 0;
fi

service_info=$(networksetup -listnetworkserviceorder | grep "$current_device")
service_name=$(echo "$service_info" | awk -F  "(, )|(: )|[)]" '{print $2}')
wifi_ssid=$(get_wifi_ssid)
network_status=""

if grep -q "USB" <<< "$service_name"; then
  network_status+="Ethernet"
  network_status+=$(get_internet_status)

  # Check if also connected to Wi-fi
  if [ -n "$wifi_ssid" ]; then
    network_status+=" | $wifi_ssid"
  fi
elif grep -q "Wi-Fi" <<< "$service_name"; then
  network_status+="$wifi_ssid"
  network_status+=$(get_internet_status)
fi

echo "$network_status"
