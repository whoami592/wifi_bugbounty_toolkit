#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
info "Local defensive audit"

OUT="$RUN_DIR/audit.txt"
{
  echo "# WiFi Bug Bounty Toolkit - Local Audit"
  echo "Timestamp: $(date -Is)"
  echo
  echo "## Kernel"
  uname -a
  echo
  echo "## NetworkManager status"
  if have nmcli; then nmcli general status; else echo "nmcli unavailable"; fi
  echo
  echo "## Wi-Fi device state"
  if have nmcli; then nmcli device status; fi
  echo
  echo "## Radio block state"
  if have rfkill; then rfkill list wifi || true; fi
  echo
  echo "## IP configuration"
  if have ip; then ip -brief address; fi
  echo
  echo "## Routing"
  if have ip; then ip route; fi
  echo
  echo "## Listening sockets (local host only)"
  if have ss; then ss -lntup 2>/dev/null || ss -lnt; else echo "ss unavailable"; fi
  echo
  echo "## Firewall summary"
  if have ufw; then ufw status verbose || true
  elif have firewall-cmd; then firewall-cmd --state; firewall-cmd --list-all || true
  elif have nft; then nft list ruleset 2>/dev/null || true
  else echo "No supported firewall command found"; fi
} | tee "$OUT"

ok "Audit evidence: $OUT"
