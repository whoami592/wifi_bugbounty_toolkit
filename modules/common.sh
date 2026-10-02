#!/usr/bin/env bash
set -Eeuo pipefail
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$BASE_DIR/reports"
mkdir -p "$REPORT_DIR"
STAMP="$(date +%Y%m%d_%H%M%S)"
RUN_DIR="$REPORT_DIR/$STAMP"
mkdir -p "$RUN_DIR"

have() { command -v "$1" >/dev/null 2>&1; }
ok() { printf "\033[32m[+]\033[0m %s\n" "$*"; }
warn() { printf "\033[33m[!]\033[0m %s\n" "$*"; }
bad() { printf "\033[31m[-]\033[0m %s\n" "$*"; }
info() { printf "\033[36m[i]\033[0m %s\n" "$*"; }
