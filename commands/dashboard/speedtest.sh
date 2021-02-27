#!/bin/bash

# Dependency: requires speedtest (https://www.speedtest.net/apps/cli)
# Install with Homebrew: `brew tap teamookla/speedtest; brew update; brew install speedtest --force`
# Afterward, accept license: `speedtest --accept-license`

# @raycast.title Speedtest
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Test download and upload connection speed using [Speedtest](https://www.speedtest.net/apps/cli).

# @raycast.icon images/speedtest-logo.png
# @raycast.mode inline
# @raycast.packageName Internet
# @raycast.refreshTime 20m
# @raycast.schemaVersion 1

if ! command -v speedtest &> /dev/null; then
	echo "speedtest command is required (https://www.speedtest.net/apps/cli).";
	exit 1;
fi

if ! command -v jq &> /dev/null; then
	echo "jq is required (https://stedolan.github.io/jq/).";
	exit 1;
fi

json=$(speedtest -f json-pretty)

report_url=$(echo "$json" | jq -r '.result.url')

    ping=$(echo "$json" | jq -r '.ping.latency')
bps_down=$(echo "$json" | jq -r '.download.bandwidth')
  bps_up=$(echo "$json" | jq -r '.upload.bandwidth')

divide_to_mbps=125000
mbps_down=$(echo "scale=2; $bps_down / $divide_to_mbps" | bc)
  mbps_up=$(echo "scale=2;   $bps_up / $divide_to_mbps" | bc)

echo "↓ ${mbps_down}mbps  ↑ ${mbps_up}mbps  ↔ ${ping}ms"
echo "Full report: $report_url"