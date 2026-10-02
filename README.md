# WiFi Bug Bounty Toolkit

**Coded by Cyber Security Engineer Mr Sabaz Ali Khan**  
**MITRIX-style banner**

A Bash-based toolkit for **authorized Wi-Fi bug-bounty and defensive assessments**.

## Features

- Environment/tool preflight
- Wi-Fi interface inventory
- Passive SSID/BSSID/security discovery via NetworkManager
- Current connection inspection
- Local IP/routing/listening-service/firewall evidence
- Timestamped evidence directories
- Markdown assessment report generation

## Requirements

Linux with:

- Bash 4+
- NetworkManager / `nmcli` (recommended)
- `iw` (optional)
- `rfkill` (optional)
- `ip`, `ss` (normally from iproute2)

## Install

```bash
chmod +x wifi-bugbounty.sh modules/*.sh
```

## Usage

```bash
sudo ./wifi-bugbounty.sh preflight
sudo ./wifi-bugbounty.sh interfaces
sudo ./wifi-bugbounty.sh networks
sudo ./wifi-bugbounty.sh inspect
sudo ./wifi-bugbounty.sh audit
sudo ./wifi-bugbounty.sh report
sudo ./wifi-bugbounty.sh all
```

## Safety / Scope

Only assess networks and systems for which you have explicit authorization.  
This project intentionally excludes:

- deauthentication/disassociation attacks
- password/handshake cracking
- credential theft
- rogue access-point impersonation
- exploitation of third-party devices
- persistence or stealth mechanisms

Those capabilities are unnecessary for a responsible bug-bounty evidence collector and can cross authorization boundaries.

## Suggested bug-bounty workflow

1. Obtain written scope.
2. Run `preflight`.
3. Run `interfaces` and `networks` for passive inventory.
4. Run `inspect` and `audit` on the authorized assessment host.
5. Validate each observation manually.
6. Remove secrets/PII from evidence.
7. Run `report`.
8. Submit only reproducible, in-scope findings through the program's official channel.
