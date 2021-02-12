#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Color Conversion
# @raycast.mode fullOutput
# @raycast.packageName Conversions

# Optional parameters:
# @raycast.icon 🎨
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "Color (e.g. #FFEEFF | RGB(..) | RGBA(..))" }
# @raycast.argument2 { "type": "text", "placeholder": "New format (e.g. RGB | RGBA | HEX)" }

# Documentation:
# @raycast.description Convert color formats (e.g. #FFEEFF -> rgba(255,238,255,1)
# @raycast.author quelhasu
# @raycast.authorURL https://github.com/quelhasu

function rgbToHex() {
  RGB=$(echo "$1" | awk -F '[()]' '{print $2}')
  IFS=,
  set $RGB
  R=$1
  G=$2
  B=$3
  printf "%02x%02x%02x" "$R" "$G" "$B"
}

color=$(echo "$1" | tr '[:upper:]' '[:lower:]')
to_format=$(echo "$2" | tr '[:upper:]' '[:lower:]')

if [ "${color:0:1}" = "#" ]; then
  hex=$(echo "${color:1:6}")
elif [ "${color:0:4}" = "rgba" ] || [ "${color:0:3}" = "rgb" ]; then
  hex=$(rgbToHex $color)
else
  echo "Color format unknown"
fi

case $to_format in

rgb)
  transformed_color=$(printf "rgb(%d,%d,%d)" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2})
  ;;

rgba)
  transformed_color=$(printf "rgba(%d,%d,%d,1)" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2})
  ;;

hex)
  transformed_color=$(echo "#${hex}")
  ;;

*)
  echo "Use correct format {HEX|RGBA|RGB}"
  ;;
esac

if [ "${transformed_color}" ]; then
  echo $transformed_color | pbcopy
  echo "Color ${color} -> ${transformed_color}"
fi
