## Story 1.9: Systemd Service for Autostart on Boot

**Story File:** `docs/stories/1.9.systemd-service-autostart.md`

**As a** developer,
**I want** the sensor sampling service to start automatically when Raspberry Pi boots,
**so that** the device operates autonomously without manual SSH login to start firmware.

### Acceptance Criteria
1. Systemd service file created: `/etc/systemd/system/opengardenlab-firmware.service`
2. Service configured to:
   - Run `python3 /home/pi/opengardenlab/firmware/sensor_service.py`
   - Restart on failure
   - Start after network.target (WiFi available)
3. Service enabled: `sudo systemctl enable opengardenlab-firmware.service`
4. Service started: `sudo systemctl start opengardenlab-firmware.service`
5. Service status verified: `sudo systemctl status opengardenlab-firmware.service` shows "active (running)"
6. Raspberry Pi rebooted, service starts automatically within 2 minutes of boot, sensor readings logged

### Labels
- `epic-1`
- `story`
