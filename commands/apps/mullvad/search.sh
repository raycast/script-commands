#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Countries, Cities, and Hostnames
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.argument2 { "type": "text", "placeholder": "Show Hostnames? (y/n)", "optional": true }
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search the list of available entities to which a Mullvad VPN tunnel connection can be made.
#
# Dependencies:
# 1. The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/
# 2. The `fzf` utility: https://github.com/junegunn/fzf

if ! command -v mullvad &> /dev/null; then
  echo "The Mullvad CLI is not installed (https://mullvad.net/en/help/cli-command-wg/)"
  exit 1
elif ! command -v fzf &> /dev/null; then
  echo "The fzf utility is not installed (https://github.com/junegunn/fzf)"
  echo "Install via Homebrew with 'brew install fzf'"
  exit 1
fi

BLUE=$'\e[1;34m'
BOLD_YELLOW=$'\e[1;33m'
BOLD_RED=$'\e[1;31m'
BOLD_GREEN=$'\e[1;32m'
END=$'\e[0m'

countries=()
cities=()
hostnames=()

colorize_location_value() {
  echo $1 | sed -r 's/\((.{'$2'})\)/\('$BOLD_YELLOW'\1'$END'\)/'
}

print_blue() {
  printf "%s%s%s\n" $BLUE $1 $END
}

print_array() {
  for i in "$@"; do
    echo "$i"
  done
}

wireguard_bias() {
  echo $1 | sed -r 's/OpenVPN/'$BOLD_RED'OpenVPN'$END'/' | sed -r 's/WireGuard/'$BOLD_GREEN'WireGuard'$END'/'
}

entities=$(mullvad relay list | fzf -i --filter "$1")

if [ ${#entities} -eq 0 ]; then
  printf "%sNo results%s found for \"%s\".\n" $BOLD_RED $END $1
  exit 0
fi

printf "The values printed in %syellow%s are meant to be used with the \"Connect to Location\" script.\n\n" $BOLD_YELLOW $END

while IFS= read -r entity; do
  if [[ "$entity" == "$(printf '\t\t')"* ]]; then
    hostname=$(echo "$entity" | sed -r 's/\t//g' | sed -r 's/^(.*) \(/'$BOLD_YELLOW'\1'$END' \(/')
    hostnames+=("$(wireguard_bias "$hostname")")

  elif [[ "$entity" == "$(printf '\t')"* ]]; then
    city=$(echo "$entity" | sed -r 's/\t(.*)@.*/\1/')
    cities+=("$(colorize_location_value "$city" 3)")

  elif [ -n "$entity" ]; then
    countries+=("$(colorize_location_value "$entity" 2)")
  fi
done <<< "$entities"

if [ ${#countries} -ne 0 ]; then
  print_blue "COUNTRIES:"
  print_array "${countries[@]}"
  echo " "
fi

if [ ${#cities} -ne 0 ]; then
  print_blue "CITIES:"
  print_array "${cities[@]}"
  echo " "
fi

if [[ -n $2 && $2 == "y" && ${#hostnames} -ne 0 ]]; then
  print_blue "HOSTNAMES:"
  print_array "${hostnames[@]}"
  echo " "
fi
