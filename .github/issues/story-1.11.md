## Story 1.11: Firmware Update Procedure Documentation

**Story File:** `docs/stories/1.11.firmware-update-procedure-docs.md`

**As a** developer,
**I want** a documented procedure for updating firmware on deployed Raspberry Pi devices,
**so that** I can fix bugs and add features to devices already in the field without re-flashing SD cards.

### Acceptance Criteria
1. Firmware update guide created: `docs/firmware-update-guide.md`
2. SSH-based update procedure documented:
   - SSH into Raspberry Pi (`ssh pi@raspberrypi.local`)
   - Stop systemd service (`sudo systemctl stop opengardenlab-firmware.service`)
   - Pull latest firmware from Git (`cd ~/opengardenlab && git pull origin main`)
   - Install updated dependencies (`pip3 install -r firmware/requirements.txt`)
   - Restart systemd service (`sudo systemctl start opengardenlab-firmware.service`)
   - Verify service running (`sudo systemctl status opengardenlab-firmware.service`)
3. Backup procedure documented (export SQLite database before update)
4. Rollback procedure documented (git checkout to previous commit if update fails)
5. Version tracking added to firmware:
   - Firmware version number in `firmware/version.txt` or `config.yaml`
   - Version logged on startup (visible in `firmware/logs/sensor_service.log`)
6. Update procedure tested: successfully update firmware on test device without data loss

### Labels
- `epic-1`
- `story`
