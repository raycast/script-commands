#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Caffeinate
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon ☕️
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Command", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Time", "percentEncoded": true, "optional": true }
#
# Documentation:
# @raycast.description Starts a caffeinated session or stops the current one
# @raycast.author Yan Smaliak
# @raycast.authorURL https://github.com/ysmaliak

command=$(echo "$1" | tr '[:upper:]' '[:lower:]')
if [[ $command == "enable" ]] || [[ $command == "e" ]]
then
    if [ -z "$2" ]
    then
        killall caffeinate
        caffeinate -t 3600 &>/dev/null &
        echo "Enable caffeinate for 1h"
    else
        unit=$(echo -n $2 | tail -c 1)
        timeValueLenght=$((${#2}-1))
        timeValue=$(echo $2 | cut -c1-$timeValueLenght)
        if [ "$timeValue" -eq "$timeValue" ] 2>/dev/null
        then
            if [[ $unit == "s" ]]
            then
                seconds=$(( $timeValue ))
            elif [[ $unit == "m" ]]
            then
                seconds=$(( $timeValue*60 ))
            elif [[ $unit == "h" ]]
            then
                seconds=$(( $timeValue*3600 ))
            elif [[ $unit == "d" ]]
            then
                seconds=$(( $timeValue*86400 ))
            else
                echo "Wrong time input!"
                exit 1
            fi
            killall caffeinate
            caffeinate -t $seconds &>/dev/null &
            echo "Enable caffeinate for $2"
        else
            echo "Wrong time input!"
            exit 1
        fi
    fi
elif [[ $command == "disable" ]] || [[ $command == "d" ]]
then
    killall caffeinate
    echo "Disable caffeinate"
else
    echo "Wrong command!"
    exit 1
fi
