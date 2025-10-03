## Story 1.2: Raspberry Pi OS Setup and SSH Access

**Story File:** `docs/stories/1.2.raspberry-pi-os-setup.md`

**As a** developer,
**I want** Raspberry Pi Zero 2 W flashed with Raspberry Pi OS and accessible via SSH,
**so that** I can remotely develop and debug firmware without needing a monitor/keyboard connected to the Pi.

### Acceptance Criteria
1. Raspberry Pi OS Lite (64-bit) flashed to 16-32GB MicroSD card using Raspberry Pi Imager
2. SSH enabled (headless setup via Raspberry Pi Imager or manual config)
3. WiFi configured for local network connectivity
4. Successfully SSH into Pi from development PC (ssh pi@raspberrypi.local)
5. Static IP assigned or hostname resolves reliably for consistent access
6. Python 3.9+ verified (pre-installed on Raspberry Pi OS)

### Labels
- `epic-1`
- `story`
