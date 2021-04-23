#!/bin/bash

# Dependency: This script requires System Preferences > Accessibility permissions to 'Control Your Computer'

# @raycast.title Do Not Disturb
# @raycast.description Manage system Do-Not-Disturb mode.
# @raycast.icon 😴
# @raycast.mode silent
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "on / off / status", "optional": true, "percentEncoded": true }
# @raycast.schemaVersion 1


# This script is an adaptation of dnd.sh from https://github.com/joeyhoer/dnd

# Set global variables
PROGNAME=$(basename "$0")
VERSION='2.0.1'
DND_PLIST_ID='com.apple.ncprefs'
DND_PLIST_KEY='dnd_prefs'
DND_PLIST="$HOME/Library/Preferences/${DND_PLIST_ID}.plist"
PROCESS_LIST=(
  usernoted
)

get_nested_plist(){
  plutil -extract $2 xml1 -o - $1 | \
    xmllint --xpath "string(//data)" - | base64 --decode | plutil -convert xml1 - -o -
}

restart_services(){
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == "" ]]; then continue; fi
    i="$line"
    if [[ $(ps aux | grep $i | awk '$0!~/grep/{print $2}') != "" ]]; then
      killall "$i" && \
      sleep 0.1 && \
      while [[ $(ps aux | grep $i | awk '$0!~/grep/{print $2}') == "" ]]; do
        sleep 0.5;
      done
    fi
  done <<< "$(printf "%s\n" "$@")"
}

get_dnd_status() {
  get_nested_plist $DND_PLIST $DND_PLIST_KEY | \
    xmllint --xpath 'boolean(//key[text()="userPref"]/following-sibling::dict/key[text()="enabled"])' -
}

enable_dnd() {
  # If the userPref key does not exist, insert it, otherwise replace it
  enable_flag="-insert"
  if get_nested_plist $DND_PLIST $DND_PLIST_KEY | \
      plutil -extract userPref xml1 - >/dev/null 2>&1; then
    enable_flag="-replace"
  fi

  DND_HEX_DATA=$(get_nested_plist $DND_PLIST $DND_PLIST_KEY | plutil $enable_flag userPref -xml "
    <dict>
        <key>date</key>
        <date>$(date -u +"%Y-%m-%dT%H:%M:%SZ")</date>
        <key>enabled</key>
        <true/>
        <key>reason</key>
        <integer>1</integer>
    </dict> " - -o - | plutil -convert binary1 - -o - | xxd -p | tr -d '\n')
  defaults write $DND_PLIST_ID $DND_PLIST_KEY -data "$DND_HEX_DATA"
  restart_services ${PROCESS_LIST[@]}
}

disable_dnd() {
  DND_HEX_DATA=$(get_nested_plist $DND_PLIST $DND_PLIST_KEY | \
    plutil -remove userPref - -o - | plutil -convert binary1 - -o - | xxd -p | tr -d '\n')
  defaults write $DND_PLIST_ID $DND_PLIST_KEY -data "$DND_HEX_DATA"
  restart_services ${PROCESS_LIST[@]}
}

echo_enabled() {
  echo "Do Not Disturb 🔕"
}

echo_disabled() {
  echo "Notifications Enabled 🔔"
}

echo_status_of_value() {
  if [[ "$1" == "true" ]]; then
    echo_enabled
  else
    echo_disabled
  fi  
}

echo_error_status_of_value() {
  if [[ "$1" == "true" ]]; then
    echo "Failed to re-enable notifications ❌"
  else
    echo "Failed to enable Do Not Disturb ❌"
  fi 
}

echo_status_expecting() {
  status=$(get_dnd_status)
  if [[ "$status" == "$1" ]]; then
      echo_status_of_value "$status"
  else
      echo_error_status_of_value "$status"
  fi
}

case $1 in

  "on"|"true"|"1"|"y")
    [[ $(get_dnd_status) == "false" ]] && enable_dnd
    echo_status_expecting "true"
    ;;

  "off"|"false"|"0"|"n")
    [[ $(get_dnd_status) == "true" ]] && disable_dnd
    echo_status_expecting "false"
    ;;

  "status"|*)
    $(get_dnd_status) && echo_enabled || echo_disabled
    ;;

esac
