#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
info "Current Wi-Fi connection inspection"
if ! have nmcli; then bad "nmcli required"; exit 1; fi

nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device status | tee "$RUN_DIR/device_status.txt"
echo
nmcli -t -f ACTIVE,SSID,BSSID,CHAN,SIGNAL,SECURITY device wifi | tee "$RUN_DIR/current_wifi.txt" || true
echo
info "NetworkManager connection profiles (names only)"
nmcli -t -f NAME,TYPE connection show | tee "$RUN_DIR/profiles.txt"

echo
info "Security observations"
if grep -Eiq '(^|:)WEP($|:)|WEP' "$RUN_DIR/current_wifi.txt" 2>/dev/null; then
  warn "WEP appears in visible scan data; WEP is obsolete and should be retired."
fi
if grep -Eiq '(^|:)--($|:)|OPEN' "$RUN_DIR/current_wifi.txt" 2>/dev/null; then
  warn "An open network may be visible. Confirm whether it is intentionally public."
fi
