#!/usr/bin/env bash
set -Eeuo pipefail
source "$(dirname "$0")/common.sh"

LATEST="$(ls -td "$REPORT_DIR"/*/ 2>/dev/null | head -1 || true)"
if [[ -z "$LATEST" ]]; then
  bad "No evidence run found. Run audit first."
  exit 1
fi

REPORT="$REPORT_DIR/wifi_assessment_$(date +%Y%m%d_%H%M%S).md"
{
  echo "# WiFi Bug Bounty Assessment Report"
  echo
  echo "**Author:** Cyber Security Engineer Mr Sabaz Ali Khan"
  echo
  echo "**Method:** Passive/local defensive assessment"
  echo
  echo "**Generated:** $(date -Is)"
  echo
  echo "> Scope must be explicitly authorized by the asset owner. This report does not claim exploitation or proof of unauthorized access."
  echo
  echo "## Evidence Directory"
  echo
  echo "\`$LATEST\`"
  echo
  echo "## Collected Evidence"
  for f in "$LATEST"/*.txt; do
    [[ -e "$f" ]] || continue
    echo "- $(basename "$f")"
  done
  echo
  echo "## Review Checklist"
  echo
  echo "- [ ] Confirm written authorization and target scope."
  echo "- [ ] Confirm SSID/BSSID ownership before reporting."
  echo "- [ ] Verify WPA2/WPA3 configuration and disable legacy WEP."
  echo "- [ ] Verify management interfaces are not exposed unnecessarily."
  echo "- [ ] Review firewall and listening-service exposure."
  echo "- [ ] Check firmware/OS update status through vendor-supported methods."
  echo "- [ ] Record evidence without collecting passwords, tokens, or personal data."
  echo
  echo "## Finding Template"
  echo
  echo "### Finding: <title>"
  echo "- Severity: <informational/low/medium/high>"
  echo "- Asset: <authorized asset>"
  echo "- Evidence: <file or screenshot>"
  echo "- Description: <what was observed>"
  echo "- Impact: <security/business impact>"
  echo "- Remediation: <vendor-supported fix>"
  echo "- Verification: <how the owner can verify remediation>"
} > "$REPORT"
ok "Report created: $REPORT"
