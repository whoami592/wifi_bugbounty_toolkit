#!/usr/bin/env bash
set -Eeuo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/modules/common.sh"

show_banner() {
  cat "$BASE_DIR/banner.txt"
  echo
  echo "  WiFi Bug Bounty Toolkit"
  echo "  Passive / authorized security assessment"
  echo "  Coded by Cyber Security Engineer Mr Sabaz Ali Khan"
  echo
}

usage() {
  cat <<EOF
Usage:
  sudo ./wifi-bugbounty.sh [command] [options]

Commands:
  preflight       Check required utilities and environment
  interfaces      Show Wi-Fi interfaces and state
  networks        Passive Wi-Fi discovery using NetworkManager
  inspect         Inspect the current connection and local Wi-Fi security
  audit           Run local defensive checks and create evidence
  report          Generate a Markdown assessment report
  all             Run preflight + interfaces + inspect + audit + report
  help            Show this help

Examples:
  sudo ./wifi-bugbounty.sh preflight
  sudo ./wifi-bugbounty.sh networks
  sudo ./wifi-bugbounty.sh audit
  sudo ./wifi-bugbounty.sh all

Safety:
  This toolkit is intentionally passive/defensive. Use only on networks,
  devices, and scopes you are authorized to assess. It does not perform
  deauthentication, password cracking, credential theft, or exploitation.
EOF
}

show_banner
case "${1:-help}" in
  preflight) "$BASE_DIR/modules/preflight.sh" ;;
  interfaces) "$BASE_DIR/modules/interfaces.sh" ;;
  networks) "$BASE_DIR/modules/networks.sh" ;;
  inspect) "$BASE_DIR/modules/inspect.sh" ;;
  audit) "$BASE_DIR/modules/audit.sh" ;;
  report) "$BASE_DIR/modules/report.sh" ;;
  all)
    "$BASE_DIR/modules/preflight.sh"
    "$BASE_DIR/modules/interfaces.sh"
    "$BASE_DIR/modules/inspect.sh"
    "$BASE_DIR/modules/audit.sh"
    "$BASE_DIR/modules/report.sh"
    ;;
  help|-h|--help) usage ;;
  *) echo "[!] Unknown command: $1"; usage; exit 2 ;;
esac
