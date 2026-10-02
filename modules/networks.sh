#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
info "Passive Wi-Fi discovery"
if ! have nmcli; then
  bad "nmcli is required for this module."
  exit 1
fi
echo "Refreshing NetworkManager scan cache..."
nmcli device wifi rescan >/dev/null 2>&1 || true
nmcli -f IN-USE,SSID,BSSID,CHAN,SIGNAL,SECURITY device wifi list | tee "$RUN_DIR/networks.txt"
echo
info "No authentication, association, deauthentication, or password testing is performed."
