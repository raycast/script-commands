#!/bin/bash

# Addapted from existing Alfred workflow
# https://github.com/packal/repository/tree/master/com.ctn.diskfree

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disk Free
# @raycast.packageName Utils
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName System
# @raycast.icon 💾

# Documentation:
# @raycast.description Show free space in your mounted disks
# @raycast.author Juan Luis Romero
# @raycast.authorURL https://github.com/JuanluR8

# EXAMPLE:
# Macintosh HD:  95%  (361 Gb) free
# 15 Gb used of 500 Gb total

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0;m' 

while read -r item; do
	[[ $item == /dev/* ]] || continue

	items=($item)
	path="${items[@]:8}"
	[[ "$path" == "/" ]] && name="$(diskutil info ${items[0]} | sed -nE 's/^ *Volume Name: +([^ ].*) *$/\1/p')" || name="${path##*/}"

	size=${items[1]:0:$((${#items[1]}-1))}
	size_unit=${items[1]:$((${#items[1]}-1))}b

	used=${items[2]:0:$((${#items[2]}-1))}
	used_unit=${items[2]:$((${#items[2]}-1))}b

	free=${items[3]:0:$((${#items[3]}-1))}
	free_unit=${items[3]:$((${#items[3]}-1))}b

	perc=$((100-${items[4]:0:$((${#items[4]}-1))}))

  color=$NC

  if [[ perc -ge 70 ]]; then
    color=$GREEN
  elif [[ perc -lt 70 ]] && [[ perc -ge 30 ]]; then
    color=$YELLOW
  else
    color=$RED
  fi

	echo -e $name':' ${color} $perc'%' ${NC} '('$free $free_unit') free'
	echo $used $used_unit 'used of' $size $size_unit 'total'
  echo ''
done < <(df -Hl)