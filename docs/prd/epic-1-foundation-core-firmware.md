# Epic 1: Foundation & Core Firmware

**Epic Goal:** Establish project infrastructure, Raspberry Pi setup, and basic sensor data collection. By the end of this epic, you'll have a Raspberry Pi device that continuously samples sensors and stores data locally, validating hardware integration before building the mobile app.

## Story 1.1: Repository Setup and Project Structure

**As a** developer,
**I want** a monorepo structure with firmware, mobile-app, and plant-database folders,
**so that** all OpenGardenLab components are organized in one Git repository with clear separation of concerns.

**Acceptance Criteria:**
1. GitHub repository `opengardenlab` created with MIT or Apache 2.0 license
2. Folder structure created: `firmware/`, `mobile-app/`, `plant-database/`, `docs/`, `scripts/`
3. README.md in root with project description, setup instructions, and link to this PRD
4. .gitignore configured for Python (firmware), Android/Kotlin (mobile-app), and common files
5. Initial commit pushed to GitHub main branch

---

## Story 1.2: Raspberry Pi OS Setup and SSH Access

**As a** developer,
**I want** Raspberry Pi Zero 2 W flashed with Raspberry Pi OS and accessible via SSH,
**so that** I can remotely develop and debug firmware without needing a monitor/keyboard connected to the Pi.

**Acceptance Criteria:**
1. Raspberry Pi OS Lite (64-bit) flashed to 16-32GB MicroSD card using Raspberry Pi Imager
2. SSH enabled (headless setup via Raspberry Pi Imager or manual config)
3. WiFi configured for local network connectivity
4. Successfully SSH into Pi from development PC (ssh pi@raspberrypi.local)
5. Static IP assigned or hostname resolves reliably for consistent access
6. Python 3.9+ verified (pre-installed on Raspberry Pi OS)

---

## Story 1.3: I2C and 1-Wire Interface Configuration

**As a** developer,
**I want** I2C and 1-Wire interfaces enabled on Raspberry Pi,
**so that** I can communicate with digital sensors (STEMMA Soil, BH1750, DHT20, DS18B20).

**Acceptance Criteria:**
1. I2C interface enabled via `raspi-config` → Interface Options → I2C
2. 1-Wire interface enabled via `raspi-config` → Interface Options → 1-Wire
3. I2C tools installed (`sudo apt install i2c-tools`)
4. I2C bus scanned successfully (`i2cdetect -y 1`) - even without sensors connected yet, command runs without error
5. 1-Wire device tree overlay loaded (verified in `/boot/config.txt` or `/boot/firmware/config.txt`)

---

## Story 1.4: Sensor Library Installation and I2C Sensor Test

**As a** developer,
**I want** Adafruit CircuitPython libraries installed and I2C sensors (STEMMA Soil, BH1750, DHT20) reading successfully,
**so that** I can validate hardware wiring and sensor functionality before building the full sampling service.

**Acceptance Criteria:**
1. Python libraries installed via pip3:
   - `adafruit-circuitpython-seesaw` (STEMMA Soil)
   - `adafruit-circuitpython-bh1750` (BH1750 light sensor)
   - `adafruit-circuitpython-ahtx0` (DHT20/AHT20 temp/humidity)
2. All I2C sensors wired to Pi (VCC, GND, SDA/Pin3, SCL/Pin5) - breadboard or STEMMA cables
3. `i2cdetect -y 1` shows sensor addresses: 0x36 (STEMMA Soil), 0x23 (BH1750), 0x38 (DHT20)
4. Simple Python test script reads and prints values from all 3 I2C sensors:
   - STEMMA Soil: moisture raw value + soil temp (°C)
   - BH1750: lux value
   - DHT20: air temp (°C) + humidity (%)
5. Test script runs without errors, values are sensible (e.g., indoor lux ~100-500, temp ~20°C)

---

## Story 1.5: 1-Wire Sensor Integration (DS18B20 Soil Temp Probe)

**As a** developer,
**I want** the DS18B20 waterproof temperature probe reading soil temperature via 1-Wire,
**so that** I have a more accurate soil temperature sensor than the STEMMA Soil's built-in sensor.

**Acceptance Criteria:**
1. DS18B20 probe wired: Red→3.3V, Black→GND, Yellow→GPIO4 (Pin7), 4.7kΩ pullup resistor between Yellow and Red
2. 1-Wire kernel modules loaded (automatic after enabling 1-Wire in story 1.3)
3. `w1thermsensor` Python library installed (`pip3 install w1thermsensor`)
4. Python test script reads DS18B20 temperature successfully (prints temp in °C and °F)
5. DS18B20 reading matches room temperature ±1°C (validation test)

---

## Story 1.6: Data Storage Service (SQLite Database Setup)

**As a** developer,
**I want** a SQLite database that stores sensor readings with timestamps,
**so that** the firmware can persist data locally for later sync to mobile app.

**Acceptance Criteria:**
1. SQLite database file created in `firmware/data/sensor_data.db`
2. Database schema created with table `sensor_readings`:
   - `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
   - `timestamp` (TEXT - ISO 8601 format)
   - `soil_moisture` (REAL - percentage 0-100)
   - `soil_temp_stemma` (REAL - °C from STEMMA sensor)
   - `soil_temp_ds18b20` (REAL - °C from DS18B20, nullable)
   - `light_lux` (REAL - lux 0-65535)
   - `air_temp` (REAL - °C from DHT20)
   - `air_humidity` (REAL - % RH from DHT20)
3. Python data access module (`firmware/storage.py`) with functions:
   - `insert_reading(timestamp, soil_moisture, soil_temp_stemma, soil_temp_ds18b20, light_lux, air_temp, air_humidity)`
   - `get_readings_since(timestamp)` - returns list of readings since given time
   - `get_latest_reading()` - returns most recent reading
4. Unit test script inserts 10 dummy readings, queries them back, verifies data integrity
5. Database file is persistent (survives Pi reboot)

---

## Story 1.7: Sensor Sampling Service (Core Firmware Loop)

**As a** developer,
**I want** a Python service that reads all sensors every N minutes and stores readings in SQLite,
**so that** the device continuously monitors garden conditions without manual intervention.

**Acceptance Criteria:**
1. Sensor sampling service implemented in `firmware/sensor_service.py` as a continuous loop:
   - Read all sensors (STEMMA Soil, BH1750, DHT20, DS18B20)
   - Insert reading into SQLite database with current timestamp
   - Sleep for configurable interval (default: 15 minutes)
   - Handle sensor read errors gracefully (log error, skip reading, continue loop)
2. Configuration file `firmware/config.yaml` with settings:
   - `sampling_interval_minutes` (default: 15)
   - `soil_moisture_calibration` (air_value, water_value - defaults for uncalibrated)
3. Sensor readings are calibrated for soil moisture (convert raw STEMMA value → 0-100% using config values)
4. Service runs in foreground initially (prints log messages to console for debugging)
5. Service tested for 1 hour: readings captured every 15 minutes, stored in database, no crashes

---

## Story 1.8: Logging and Health Check Indicator

**As a** developer,
**I want** structured logging and a visual health indicator (LED or console message),
**so that** I can monitor firmware status and troubleshoot issues during development.

**Acceptance Criteria:**
1. Python logging configured with rotating file handler: `firmware/logs/sensor_service.log`
2. Log levels used appropriately:
   - INFO: Successful sensor readings ("Read sensors: moisture=45%, lux=12000, temp=22°C")
   - WARNING: Sensor read errors ("Failed to read BH1750, retrying...")
   - ERROR: Critical failures ("Database connection failed")
3. Optional: GPIO LED blink every sampling cycle (LED on Pin 17, blinks for 1 second after each successful reading)
4. Logs rotate after 10MB, keep last 5 log files
5. SSH into Pi, tail logs in real-time (`tail -f firmware/logs/sensor_service.log`) to observe sampling

---

## Story 1.9: Systemd Service for Autostart on Boot

**As a** developer,
**I want** the sensor sampling service to start automatically when Raspberry Pi boots,
**so that** the device operates autonomously without manual SSH login to start firmware.

**Acceptance Criteria:**
1. Systemd service file created: `/etc/systemd/system/opengardenlab-firmware.service`
2. Service configured to:
   - Run `python3 /home/pi/opengardenlab/firmware/sensor_service.py`
   - Restart on failure
   - Start after network.target (WiFi available)
3. Service enabled: `sudo systemctl enable opengardenlab-firmware.service`
4. Service started: `sudo systemctl start opengardenlab-firmware.service`
5. Service status verified: `sudo systemctl status opengardenlab-firmware.service` shows "active (running)"
6. Raspberry Pi rebooted, service starts automatically within 2 minutes of boot, sensor readings logged

---

## Story 1.10: CI/CD Pipeline Setup with GitHub Actions

**As a** developer,
**I want** automated testing and build pipelines using GitHub Actions,
**so that** I can catch bugs early, ensure code quality, and automate builds for firmware and mobile app.

**Acceptance Criteria:**
1. GitHub Actions workflow file created: `.github/workflows/ci.yml`
2. Firmware testing pipeline configured:
   - Install Python dependencies (requirements.txt)
   - Run pytest for all firmware unit tests
   - Run Python linter (flake8 or pylint)
   - Execute on every pull request and push to main branch
3. Mobile app build pipeline configured:
   - Build Android APK (debug variant)
   - Run unit tests (JUnit for Kotlin or NUnit for .NET MAUI)
   - Run lint checks (Android Lint)
   - Execute on every pull request and push to main branch
4. Test framework dependencies added:
   - `pytest` added to `firmware/requirements.txt`
   - JUnit/Espresso (Kotlin) or NUnit (.NET MAUI) configured in mobile app
5. CI status badge added to README.md showing build status
6. First CI run completes successfully (all tests pass)

**Notes:**
- Start with simple pipeline, expand over time (e.g., add code coverage reporting in Phase 2)
- Free GitHub Actions minutes sufficient for solo developer project
- Enables test-driven development and prevents regressions

---

## Story 1.11: Firmware Update Procedure Documentation

**As a** developer,
**I want** a documented procedure for updating firmware on deployed Raspberry Pi devices,
**so that** I can fix bugs and add features to devices already in the field without re-flashing SD cards.

**Acceptance Criteria:**
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

**Post-MVP Enhancements (Phase 2):**
- Over-the-air (OTA) updates via Bluetooth (mobile app sends firmware file to Pi)
- Automatic rollback if new firmware crashes within 5 minutes

---

**Epic 1 Complete:** At this point, you have a fully functional firmware device that samples sensors continuously and stores data. Even without mobile app, you can SSH into Pi and query SQLite database to see sensor history.

---
