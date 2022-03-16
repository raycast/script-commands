#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Battery Info
# @raycast.mode inline
# @raycast.refreshTime 3m
# @raycast.packageName System

#
# Optional parameters:
# @raycast.icon 🔋
#
# Documentation:
# @raycast.description Get Battery percentage, time remaining, charge status, charger wattage, total cycles etc.
# @raycast.author Fahim Faisal
# @raycast.authorURL https://github.com/i3p9

BATT_PERCENTAGE=$(pmset -g batt | grep "InternalBattery-0" |  awk '{print $3}')
CHARGE_STATUS=$(pmset -g batt | grep "InternalBattery-0" |  awk '{print $4}')
TIME_REMAINING=$(pmset -g batt | grep "InternalBattery-0" |  awk '{print $5}')
CYCLE_COUNT=$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')
CHARGE_WATT=$(pmset -g ac | grep "Wattage" | awk '{print $3}')

BATT=${BATT_PERCENTAGE%??}

if [[ "$CHARGE_STATUS" == "charging;" ]]; then
    #Charging
    if [[ "$TIME_REMAINING" == "(no" ]]; then
        TO_SHOW="⚡${BATT}% - No Estimation Yet (Charging at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    else
        if [[ "$TIME_REMAINING" != "(no" ]]; then
            RE_MIN=${TIME_REMAINING##*:}
            RE_HOUR=${TIME_REMAINING%%:*}
            if [[ "$RE_HOUR" == "0" ]]; then
                TIME_REMAINING_FORMATTED="${RE_MIN}m"
            else
                TIME_REMAINING_FORMATTED="${RE_HOUR}h ${RE_MIN}m"
            fi
        fi
        TO_SHOW="⚡${BATT}% - ${TIME_REMAINING_FORMATTED} to Full (Charging at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    fi
elif [[ "$CHARGE_STATUS" == "finishing" ]]; then
    #Finishing Charning, xx:xx time remaining
    TIME_REMAINING=$(pmset -g batt | grep "InternalBattery-0" |  awk '{print $6}')
    RE_MIN=${TIME_REMAINING##*:}
    RE_HOUR=${TIME_REMAINING%%:*}
    if [[ "$RE_HOUR" == "0" ]]; then
        if [[ "$RE_MIN" == "00" ]]; then
            FULLY_CHARGED_FLAG="TRUE"
        fi
        TIME_REMAINING_FORMATTED="${RE_MIN}m"
    else
        TIME_REMAINING_FORMATTED="${RE_HOUR}h ${RE_MIN}m"
    fi

    if [[ "$TIME_REMAINING" == "(no" ]]; then
        TO_SHOW="⚡${BATT}% - No Estimation Yet (Charging at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    elif [[ "$FULLY_CHARGED_FLAG" = "TRUE" ]]; then
        TO_SHOW="⚡${BATT}% - Fully Charged (Power Connected at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    else
        TO_SHOW="⚡${BATT}% - ${TIME_REMAINING_FORMATTED} to Full (Charging at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    fi

elif [[ "$CHARGE_STATUS" == "charged;" ]]; then
    #Fully charged
    TO_SHOW="⚡${BATT}% - Fully Charged (Power Connected at ${CHARGE_WATT}) - ${CYCLE_COUNT} Cycles"
   echo $TO_SHOW

elif [[ "$CHARGE_STATUS" == "discharging;" ]]; then
    #Discharging
    if [[ "$TIME_REMAINING" == "(no" ]]; then
        TO_SHOW="${BATT}% - No Estimation Yet - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    else
        if [[ "$TIME_REMAINING" != "(no" ]]; then
            RE_MIN=${TIME_REMAINING##*:}
            RE_HOUR=${TIME_REMAINING%%:*}
            if [[ "$RE_HOUR" == "0" ]]; then
                TIME_REMAINING_FORMATTED="${RE_MIN}m"
            else
                TIME_REMAINING_FORMATTED="${RE_HOUR}h ${RE_MIN}m"
            fi
        fi
        TO_SHOW="${BATT}% - ${TIME_REMAINING_FORMATTED} Remaining - ${CYCLE_COUNT} Cycles"
        echo $TO_SHOW
    fi
fi
