#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
info "Wireless interfaces"
if have nmcli; then
  nmcli -f DEVICE,TYPE,STATE,CONNECTION device status | tee "$RUN_DIR/interfaces.txt"
elif have iw; then
  iw dev | tee "$RUN_DIR/interfaces.txt"
else
  bad "Neither nmcli nor iw is installed."
fi
if have rfkill; then
  echo
  info "RF-kill status"
  rfkill list wifi | tee "$RUN_DIR/rfkill.txt" || true
fi
