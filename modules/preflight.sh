#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"
info "Preflight checks"
for cmd in bash awk sed grep date uname; do
  if have "$cmd"; then ok "$cmd"; else bad "$cmd missing"; fi
done
for cmd in nmcli iw rfkill; do
  if have "$cmd"; then ok "$cmd available"; else warn "$cmd not installed (some checks unavailable)"; fi
done
if [[ $EUID -eq 0 ]]; then ok "Running with root privileges"; else warn "Not running as root; some interface details may be unavailable"; fi
uname -a | tee "$RUN_DIR/system.txt"
