#!/bin/bash

# Raycast Script Command
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle SSH SOCKS Tunnel
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName Developer Utilities
#
# Documentation:
# @raycast.description Toggles an SSH SOCKS proxy tunnel on and off.
# @raycast.author Andrii Barabash
# @raycast.authorURL https://github.com/AndriiBarabash

# --- Configuration ---
# Replace these with your own values
SSH_USER="<your_user>"
SSH_HOST="<your_host>"
SSH_PORT="<your_port>"
INTERFACE="<your_network_interface>" # e.g., "Wi-Fi" or "Ethernet"
PROXY_PORT="<your_proxy_port>"       # e.g., 1080
# --- End Configuration ---

if pgrep -f "ssh -D $PROXY_PORT" >/dev/null; then
  echo "SSH SOCKS tunnel is running. Turning it off..."

  # Kill the SSH process
  pkill -f "ssh -D $PROXY_PORT"

  # Disable the SOCKS proxy
  networksetup -setsocksfirewallproxystate "$INTERFACE" off

  echo "Tunnel and proxy disabled."
else
  echo "SSH SOCKS tunnel is not running. Turning it on..."

  # Start the SSH tunnel
  ssh -D "$PROXY_PORT" -f -C -q -N -p "$SSH_PORT" "$SSH_USER"@"$SSH_HOST"

  # Enable the SOCKS proxy
  networksetup -setsocksfirewallproxy "$INTERFACE" 127.0.0.1 "$PROXY_PORT"
  networksetup -setsocksfirewallproxystate "$INTERFACE" on

  echo "Tunnel and proxy enabled."
fi
