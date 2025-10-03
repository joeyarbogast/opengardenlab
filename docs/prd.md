# OpenGardenLab Product Requirements Document (PRD)

**Project:** OpenGardenLab IoT Garden Monitoring System
**Version:** 1.0
**Status:** Draft
**Author:** Product Manager (John)
**Date:** 2025-10-02

---

## Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-10-02 | 1.0 | Initial PRD draft | Product Manager (John) |

---

## Goals and Background Context

### Goals

- Build a working IoT garden monitoring system that successfully captures and syncs sensor data (moisture, light, temperature) for real-world garden conditions
- Create actionable plant recommendations based on sensor readings compared to optimal ranges, helping diagnose and prevent plant problems
- Develop practical skills in hardware integration, Python firmware development, Android mobile app development, and IoT architecture
- Establish a solid foundation that supports future expansion with diagnostic features, additional sensors, and multi-device architecture
- Share the project openly as an open-source tool that other home gardeners can build and benefit from

### Background Context

Home gardeners face a frustrating problem: when plants show symptoms like yellowing leaves or wilting, online searches return 10+ possible causes without clear guidance on identifying the actual root cause. This leads to trial-and-error remediation, wasted time, preventable plant loss, and analysis paralysis from information overload.

Existing commercial garden monitors are expensive ($200+), require cloud subscriptions, are closed-source, and focus on automation rather than helping gardeners understand and diagnose problems. Plant care apps provide generic advice without real sensor data from YOUR specific garden conditions.

OpenGardenLab addresses this gap by combining affordable IoT sensor hardware with a local-first mobile app that provides data-driven plant care recommendations. The MVP focuses on continuous monitoring of core environmental factors (soil moisture, light intensity, temperature) and comparing actual conditions against optimal ranges for specific plant types. This provides gardeners with concrete, actionable insights: "Your tomatoes are receiving only 4 hours of sun daily but need 6-8 hours" or "Soil moisture has been below 30% for 5 days; tomatoes prefer 40-60%."

Unlike commercial solutions, OpenGardenLab is:
- **Open source** - complete transparency, no vendor lock-in
- **Local-first** - no cloud dependency, no subscriptions, complete data ownership
- **Learning-focused** - designed as a personal learning project in IoT/mobile development while solving a real problem
- **Modular & expandable** - start with MVP sensors, expand with diagnostics, advanced sensors, and multi-device support in future phases

This project builds on extensive Phase 1 research validating technical feasibility:
- **Hardware platform selected:** Raspberry Pi Zero 2 W with Python (faster development, superior debugging vs ESP32/C++)
- **Sensors identified:** All I2C digital sensors (STEMMA Soil, BH1750 light, DHT20 temp/humidity) - no ADC needed
- **Plant database strategy:** Manual curation from university extension guides (50-75 plants for MVP)
- **Budget validated:** $99-150 per device (well under $300 target)
- **Timeline validated:** 4-6 months part-time is realistic for solo developer

**Phase 1 research complete.** This PRD translates that research into specific product requirements for MVP development.

---

## Requirements

### Functional

**FR1:** The system shall continuously monitor soil moisture levels (every 15-60 minutes, configurable) and store readings locally on the device with timestamps.

**FR2:** The system shall continuously monitor light intensity in lux (every 15-60 minutes) and calculate daily light hour totals to compare against plant requirements.

**FR3:** The system shall continuously monitor air temperature and humidity (every 15-60 minutes) to track ambient garden conditions.

**FR4:** The device shall store at least 30 days of sensor readings locally on the device (Raspberry Pi) to enable trend analysis even without frequent mobile app syncs.

**FR5:** The device shall sync collected sensor data to the mobile app via Bluetooth Low Energy when the user brings their mobile device within range (typically 30-100 feet).

**FR6:** The mobile app shall support multiple devices (multi-zone gardening), allowing users to label each device (e.g., "Tomato Bed", "Herb Garden") and switch between them to view data independently.

**FR7:** The mobile app shall include a comprehensive plant database with at least 50 common vegetables, fruits, and herbs, containing optimal ranges for soil moisture (%), light hours/day (lux), and temperature (°C).

**FR8:** The mobile app shall allow users to assign a plant type to each device/garden zone from the plant database.

**FR9:** The system shall generate basic recommendations by comparing actual sensor readings (averaged over configurable periods like 24 hours, 7 days) to optimal ranges for the assigned plant type and displaying actionable guidance.

**FR10:** The mobile app shall visualize sensor data using time-series charts with multiple views (daily, weekly, monthly) to help users identify trends and patterns.

**FR11:** The system shall include a garden journal feature where users can add timestamped notes, observations, and actions taken (e.g., "Watered 2 cups", "Added fertilizer"), attachable to specific devices/zones.

**FR12:** The device firmware shall be accessible via SSH for debugging, configuration updates, and manual data inspection by the developer.

**FR13:** The system shall allow one-time sensor calibration for soil moisture (air reading = 0%, water reading = 100%) with calibration values stored in device configuration.

**FR14:** The system shall operate entirely offline (no internet required after initial setup) - all sensor data storage, processing, and plant database queries shall work without external network connectivity.

### Non-Functional

**NFR1:** Device battery life shall be at least 7 days using swappable 20,000mAh USB power banks without solar charging (allowing weekly battery swap cycle).

**NFR2:** Bluetooth sync between device and mobile app shall complete within 5 minutes for 30 days of sensor data (15-minute intervals).

**NFR3:** Sensor readings shall be accurate enough for gardening decisions: soil moisture ±5%, light ±20%, temperature ±1°C (calibrated sensors).

**NFR4:** The device shall be deployable outdoors in a weatherproof enclosure (IP65 rated) and withstand outdoor conditions (rain, sun, temperature swings -10°C to 50°C).

**NFR5:** The total hardware cost per device shall not exceed $150 including Raspberry Pi, sensors, power, enclosure, and accessories.

**NFR6:** All software components (firmware, mobile app, plant database) shall be open-source under a permissive license (MIT or Apache 2.0 for code, CC0 or CC-BY for plant data).

**NFR7:** The system shall be buildable by a solo developer with .NET/web background but new to IoT hardware, following documented setup guides and leveraging community resources (Adafruit tutorials, Python libraries).

**NFR8:** The mobile app UI shall be intuitive enough for non-technical home gardeners to use without extensive documentation - core tasks (viewing data, assigning plants, reading recommendations) should be self-explanatory.

**NFR9:** The plant database shall cite authoritative sources (university extension guides) for all optimal range data to ensure recommendations are scientifically grounded.

**NFR10:** The firmware shall support future extensibility: adding new sensor types (NPK, pH, camera) should not require major architectural changes.

---

## User Interface Design Goals

### Overall UX Vision

The mobile app should feel like a **friendly garden assistant** that helps you understand what's happening in your garden without overwhelming you with data. The core experience is:
1. **Glanceable status** - quickly see if plants are happy or need attention
2. **Clear recommendations** - actionable guidance in plain language (not just numbers)
3. **Trend awareness** - beautiful charts that make patterns obvious (moisture dropping, light increasing over spring)
4. **Low friction** - minimal setup, automatic data sync, works offline

Target feeling: **Confidence, not confusion.** Users should feel empowered to make informed decisions, not paralyzed by data.

### Key Interaction Paradigms

**Data-First, Not Configuration-Heavy:**
- Primary flow: Open app → See latest data immediately → Review recommendations
- Not: Navigate through menus to find settings → Configure thresholds → Then see data

**Progressive Disclosure:**
- MVP shows essential info first (current readings, status, simple recommendations)
- Tap to drill down for detailed charts, historical trends, journal entries
- Advanced features (multi-device management, calibration) accessible but not front-and-center

**Offline-First:**
- All core features work without internet (view data, recommendations, add journal entries)
- Bluetooth sync is explicit user action (tap "Sync" button when in range)
- Clear sync status indicator (last synced timestamp, "sync needed" badge)

### Core Screens and Views

MVP requires these essential screens:

1. **Device Dashboard** - Primary screen after opening app
   - Current sensor readings (moisture %, lux, temp, humidity) with color-coded status
   - Assigned plant info (photo, name, optimal ranges)
   - Simple recommendation banner (e.g., "Soil is drier than optimal. Consider watering.")
   - Last sync timestamp
   - Quick access to: Sync button, historical charts, device settings

2. **Historical Data / Charts** - Tap on any sensor reading
   - Time-series line charts for each sensor (moisture, light, temp, humidity)
   - View options: 24 hours, 7 days, 30 days
   - Overlay optimal range (shaded area) vs actual readings (line graph)
   - Identify trends visually (e.g., moisture declining, light hours increasing)

3. **Plant Selection** - Assign plant type to device
   - Browse or search plant database (50+ plants)
   - Categorized: Vegetables, Fruits, Herbs
   - View optimal ranges for each plant before assigning
   - Quick assign (one tap to confirm)

4. **Recommendations / Insights** - Dedicated recommendations view
   - List of current recommendations (moisture low, light too high, etc.)
   - Trend-based insights (e.g., "Moisture has dropped 20% over last 3 days")
   - Explain WHY (compare to plant's optimal range)
   - Suggested actions ("Water 1-2 cups daily until moisture reaches 40-60%")

5. **Garden Journal** - Note-taking
   - Chronological list of user notes + auto-generated entries (e.g., "Device synced", "Plant assigned")
   - Add note: text entry, timestamp auto-added
   - Attach to specific device/zone
   - Filter by device, date range

6. **Device List / Multi-Device** - Switch between devices
   - List of all paired devices with labels ("Tomato Bed", "Herb Garden")
   - Quick device switcher (swipe or dropdown)
   - Add new device (Bluetooth pairing flow)
   - Edit device name/label

7. **Device Settings / Calibration**
   - Configure sampling interval (15 min, 30 min, 60 min)
   - Run soil moisture calibration (air reading, water reading)
   - View device info (Raspberry Pi ID, firmware version, storage usage)
   - Unpair device

### Accessibility

**Target:** WCAG AA compliance (MVP)

Specific requirements:
- Minimum touch target size: 44x44 points (iOS) / 48x48dp (Android)
- Color is not the only indicator (use icons + text for status: red + ⚠️ for "low moisture")
- Text contrast ratio ≥4.5:1 for normal text, ≥3:1 for large text
- Support system font size preferences (scale UI text)
- All interactive elements have accessible labels for screen readers

### Branding

**Style:** Clean, modern, gardening-inspired

- **Color palette:**
  - Primary: Earthy green (#4CAF50 or similar - represents healthy plants)
  - Accent: Warm orange/amber (#FF9800 - represents alerts/sun)
  - Backgrounds: White/light gray (clean, readable)
  - Status colors: Green (good), Yellow (caution), Red (alert)

- **Typography:**
  - Sans-serif, readable (Roboto on Android, system default)
  - Clear hierarchy (large titles, readable body text)

- **Imagery:**
  - Plant photos from plant database (show assigned plant on dashboard)
  - Icons for sensors (droplet for moisture, sun for light, thermometer for temp)

- **Tone:**
  - Friendly, encouraging, educational (not technical/intimidating)
  - Example: "Your tomatoes are loving that sunshine! ☀️" vs "Lux reading: 45,000"

### Target Device and Platforms

**MVP:** Android native app only
- Minimum Android version: TBD (likely Android 8.0+ for Bluetooth LE APIs)
- Target: Phones and tablets (responsive layout)
- Screen sizes: 5" to 10" (optimize for typical phone size ~6")

**Post-MVP:** iOS, web dashboard (future phases)

**Why Android-first:**
- Developer has Android device for testing
- Bluetooth LE APIs well-supported on Android 8.0+
- Faster development (native Android or .NET MAUI leveraging .NET background)

---

## Technical Assumptions

### Repository Structure

**Monorepo** (single repository for all components)

Rationale:
- Easier to keep firmware, mobile app, and plant database in sync
- Atomic commits across components (e.g., firmware protocol change + app update)
- Simpler for solo developer (one repo to manage)
- GitHub Actions can build/test all components from one CI/CD pipeline

Structure:
```
opengardenlab/
├── firmware/          # Python firmware for Raspberry Pi Zero
├── mobile-app/        # Android app (Kotlin or .NET MAUI)
├── plant-database/    # YAML plant data files
├── docs/              # Documentation (this PRD, architecture, guides)
├── hardware/          # Schematics, enclosure designs (future)
└── scripts/           # Build scripts, YAML→JSON compiler
```

### Service Architecture

**Monolith** (single firmware service on Raspberry Pi)

Rationale:
- MVP is simple: read sensors, store data, sync via Bluetooth
- No need for microservices complexity (no distributed system)
- All components run on one device (Pi Zero 2 W)

Firmware components (all in one Python application):
- **Sensor sampling service** - reads I2C/1-Wire sensors every N minutes
- **Data storage service** - writes readings to local SQLite or TinyDB
- **Bluetooth server** - advertises device, accepts mobile app connections, syncs data
- **Configuration manager** - reads/writes device config (calibration, sampling interval)

Post-MVP: If adding ESP32 nodes (Phase 2 multi-zone), Pi Zero becomes "hub" service coordinating multiple edge nodes.

### Testing Requirements

**Unit + Integration testing** (no E2E for MVP)

MVP testing strategy:
- **Firmware:**
  - Unit tests for sensor reading logic (mocked I2C responses)
  - Integration tests for SQLite/TinyDB storage
  - Manual integration testing with real sensors (no automated E2E for hardware)
  - Logging + SSH access for debugging

- **Mobile app:**
  - Unit tests for data parsing, plant database queries
  - UI tests for critical flows (view dashboard, sync device)
  - Manual testing on physical Android device(s)

- **Plant database:**
  - JSON schema validation (automated CI check)
  - Manual review of plant optimal ranges (cite sources)

**No comprehensive E2E testing initially** (resource-intensive for solo developer). Focus on **manual testing with real hardware** in actual garden deployment.

### Additional Technical Assumptions and Requests

**Firmware (Raspberry Pi Zero 2 W):**
- **Language:** Python 3.9+ (accessible from .NET background, rich IoT libraries)
- **GPIO library:** Adafruit CircuitPython / gpiozero (well-documented, beginner-friendly)
- **Bluetooth:** bluepy or bleak (Bluetooth LE support)
- **Data storage:** SQLite (built-in to Python, lightweight) or TinyDB (simpler JSON-based alternative)
- **Development environment:** VS Code Remote SSH (SSH into Pi, full IDE experience)

**Mobile app:**
- **Platform:** Android native
- **Framework/Language:** **TBD** - evaluate during architecture phase:
  - Option 1: Kotlin (Android native, full Bluetooth control, industry standard)
  - Option 2: .NET MAUI (leverage .NET background, cross-platform potential for iOS later)
- **Bluetooth library:** Android Bluetooth LE APIs (native) or .NET MAUI Bluetooth plugin
- **Local database:** Room (Kotlin) or SQLite.NET (.NET MAUI)
- **Charts:** MPAndroidChart (Kotlin) or Microcharts (.NET MAUI)

**Plant database:**
- **Source format:** YAML files (human-readable, Git-friendly, citation-friendly)
- **Distribution format:** JSON bundled with mobile app (compiled from YAML via script)
- **Schema:** JSON schema validation (CI pipeline checks)
- **License:** CC0 (public domain) or CC-BY 4.0 (attribution)

**Hardware:**
- Raspberry Pi Zero 2 W: $16-20
- Sensors: $19-29 (STEMMA Soil, BH1750, DHT20, optional DS18B20)
- Power: 2× 10,000-20,000mAh USB power banks ($30-50, swappable weekly)
- MicroSD: 16-32GB high-endurance ($8-12)
- Enclosure: IP65 waterproof box ($12-20)
- **Total cost per device:** $87-120 (within budget)

**Power strategy:**
- **MVP:** Swappable USB power banks (charge one while using one)
- **Post-MVP:** Solar panel + charge controller (Phase 2)

**Bluetooth protocol:**
- **BLE preferred** over Bluetooth Classic (lower power, better mobile support)
- **Data format:** JSON for sync messages (simple, human-readable)
- **Connection model:** Mobile app initiates connection, requests data since last sync, disconnects

**Sensor details:**
- Adafruit STEMMA Soil Sensor (4026): I2C capacitive moisture + soil temp
- Adafruit BH1750 (4681): I2C light sensor (1-65,535 lux)
- Adafruit DHT20/AHT20 (5183): I2C air temp + humidity (replaces discontinued DHT22)
- Optional: DS18B20 waterproof probe (1-Wire soil temp, more accurate than STEMMA)

**Architecture notes:**
- All sensors use I2C or 1-Wire (no analog ADC needed - simplifies wiring)
- GPIO pins used: 2 for I2C (SDA, SCL), 1 for 1-Wire (GPIO4) = 3 total
- 37+ GPIO pins remain free for future sensor expansion

---

## Epic List

This section provides a high-level overview of the major epics for OpenGardenLab MVP. Each epic delivers a significant, end-to-end increment of testable functionality. Epics are sequenced to ensure each builds upon the foundation of previous work.

### Epic 1: Foundation & Core Firmware
**Goal:** Establish project infrastructure, Raspberry Pi setup, and basic sensor data collection.

This epic delivers the foundational firmware that can read sensors and store data locally. By the end of this epic, you'll have a working Raspberry Pi device that samples sensors every N minutes and logs data, even though there's no mobile app yet. This validates hardware integration and provides a solid base for Bluetooth sync.

**Key deliverables:**
- Git repository structure (monorepo)
- Raspberry Pi OS setup with Python environment
- Sensor sampling service (reads STEMMA Soil, BH1750, DHT20, DS18B20)
- Local data storage (SQLite or TinyDB)
- Logging and basic health check (LED blink or console output)

---

### Epic 2: Mobile App Foundation & Plant Database
**Goal:** Create Android mobile app structure, load plant database, and implement core UI screens (dashboard, plant selection).

This epic establishes the mobile app skeleton with navigation, plant database integration, and basic UI. By the end, you'll have an app that can browse plants and view dummy sensor data, setting the stage for Bluetooth sync integration.

**Key deliverables:**
- Android app project setup (Kotlin or .NET MAUI)
- Plant database (YAML → JSON, bundled with app)
- Device Dashboard screen (mock data initially)
- Plant Selection screen (browse/search 50+ plants)
- Data visualization library integration (charts - mock data)

---

### Epic 3: Bluetooth Sync & Data Integration
**Goal:** Implement Bluetooth communication between Raspberry Pi firmware and mobile app, enabling device pairing and data synchronization.

This epic is the critical integration point that connects firmware and mobile app. By the end, you'll have a fully functional end-to-end system: sensors → firmware → Bluetooth → mobile app → charts & recommendations.

**Key deliverables:**
- Bluetooth BLE server on Raspberry Pi (Python bluepy/bleak)
- Bluetooth BLE client in mobile app (Android APIs)
- Device pairing and discovery flow
- Data sync protocol (JSON messages)
- Real sensor data displayed in mobile app (replacing mock data)

---

### Epic 4: Recommendations Engine & Multi-Device Support
**Goal:** Generate actionable plant care recommendations based on sensor data vs optimal ranges, and support managing multiple garden devices/zones.

This epic completes the MVP by delivering the core value proposition: helping gardeners make data-driven decisions. By the end, users can monitor multiple garden beds, see clear recommendations ("water more", "too much sun"), and keep a garden journal.

**Key deliverables:**
- Recommendation logic (compare actual vs optimal, generate insights)
- Recommendations screen with actionable guidance
- Multi-device management (device list, labels, switcher)
- Garden journal (note-taking, timestamps)
- Device settings (calibration, sampling interval configuration)

---

**MVP Complete:** After Epic 4, OpenGardenLab delivers a working end-to-end system that monitors garden conditions, syncs to mobile app, and provides plant care recommendations. All remaining features (diagnostics, advanced sensors, web dashboard, community contributions) are deferred to post-MVP phases.

---

## Epic 1: Foundation & Core Firmware

**Epic Goal:** Establish project infrastructure, Raspberry Pi setup, and basic sensor data collection. By the end of this epic, you'll have a Raspberry Pi device that continuously samples sensors and stores data locally, validating hardware integration before building the mobile app.

### Story 1.1: Repository Setup and Project Structure

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

### Story 1.2: Raspberry Pi OS Setup and SSH Access

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

### Story 1.3: I2C and 1-Wire Interface Configuration

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

### Story 1.4: Sensor Library Installation and I2C Sensor Test

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

### Story 1.5: 1-Wire Sensor Integration (DS18B20 Soil Temp Probe)

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

### Story 1.6: Data Storage Service (SQLite Database Setup)

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

### Story 1.7: Sensor Sampling Service (Core Firmware Loop)

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

### Story 1.8: Logging and Health Check Indicator

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

### Story 1.9: Systemd Service for Autostart on Boot

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

### Story 1.10: CI/CD Pipeline Setup with GitHub Actions

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

### Story 1.11: Firmware Update Procedure Documentation

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

## Epic 2: Mobile App Foundation & Plant Database

**Epic Goal:** Create Android mobile app structure, load plant database, and implement core UI screens (dashboard, plant selection). By the end, you'll have an app that can browse plants and display mock sensor data, ready for Bluetooth integration.

### Story 2.1: Android Project Setup and Navigation Framework

**As a** developer,
**I want** an Android app project with navigation between screens,
**so that** I have the foundation for building OpenGardenLab mobile app UI.

**Acceptance Criteria:**
1. Android project created in `mobile-app/` folder using Android Studio or VS Code + .NET MAUI
2. Framework decision finalized (Kotlin native or .NET MAUI) based on developer preference
3. Minimum Android SDK version set (Android 8.0 / API 26 for BLE support)
4. Navigation framework configured (Jetpack Navigation for Kotlin, or .NET MAUI Shell)
5. App builds successfully and runs on Android device/emulator
6. Basic navigation between 3 placeholder screens: Dashboard, Plant Selection, Settings

---

### Story 2.2: Plant Database YAML Structure and Compilation Script

**As a** developer,
**I want** YAML plant data files compiled to JSON for app bundling,
**so that** the mobile app can load plant care information offline without external APIs.

**Acceptance Criteria:**
1. YAML schema defined for plant profiles in `plant-database/schema/plant-schema.yaml`
2. Folder structure created: `plant-database/vegetables/`, `plant-database/herbs/`, `plant-database/fruits/`
3. 5 sample plant YAML files created (e.g., tomato-cherry.yaml, basil.yaml) with full optimal ranges
4. Python compilation script `scripts/compile-plants.py` that:
   - Reads all YAML files from plant-database/
   - Validates against schema
   - Outputs single `plants.json` file
5. JSON file copied to mobile app assets folder (`mobile-app/assets/plants.json`)
6. Compilation script tested: YAML → JSON conversion works, validates schema

---

### Story 2.3: Plant Database Curation (Initial 25 Plants - Tier 1)

**As a** product manager,
**I want** 25 common garden plants documented with optimal care ranges,
**so that** the mobile app has sufficient plant data for MVP testing and early users.

**Acceptance Criteria:**
1. 25 plant YAML files created (from MVP plant list: tomato, pepper, lettuce, cucumber, basil, etc.)
2. Each plant profile includes:
   - Common name, scientific name, category (vegetable/herb/fruit)
   - Optimal soil moisture range (min/max %)
   - Light requirements (hours/day, lux range)
   - Air temperature range (min/max °C)
   - Sources cited (university extension guides)
3. All profiles validated against YAML schema (no errors in compilation script)
4. plants.json compiled and bundled with mobile app
5. Spot-check: 5 random plants manually verified against source documents for accuracy

---

### Story 2.4: Plant Database Loader and Query Service (Mobile App)

**As a** mobile app,
**I want** to load plants.json on app startup and provide plant query functions,
**so that** UI screens can browse, search, and display plant information.

**Acceptance Criteria:**
1. Plant database loader service created (`PlantDatabaseService` or similar)
2. plants.json loaded from app assets on startup, parsed into memory (list of plant objects)
3. Query functions implemented:
   - `getAllPlants()` - returns all plants
   - `searchPlants(query: String)` - case-insensitive search by common name
   - `getPlantsByCategory(category: String)` - filter by "vegetable", "herb", "fruit"
   - `getPlantById(id: String)` - get specific plant by ID/name
4. Unit tests verify query functions work correctly (search "tomato" returns 3+ varieties, etc.)
5. Plant data persists across app restarts (no re-parsing JSON every launch - cache in memory)

---

### Story 2.5: Device Dashboard Screen with Mock Data

**As a** user,
**I want** a dashboard screen that shows current sensor readings and plant info,
**so that** I can see garden status at a glance (using mock data initially, real data in Epic 3).

**Acceptance Criteria:**
1. Dashboard screen UI created with layout:
   - Device name/label at top ("Tomato Bed")
   - Current sensor readings: Soil Moisture (%), Light (lux), Temperature (°C), Humidity (%)
   - Each reading has icon (droplet, sun, thermometer, water drop) and color-coded status (green/yellow/red)
   - Assigned plant info card (plant photo placeholder, name, optimal ranges)
   - Last sync timestamp ("Synced 5 minutes ago")
   - Sync button (does nothing yet, placeholder for Epic 3)
2. Mock data hardcoded for testing:
   - Soil moisture: 45%, Light: 12,000 lux, Temp: 22°C, Humidity: 55%
   - Assigned plant: "Cherry Tomato"
3. Dashboard displays mock data correctly, layout looks clean and readable
4. Navigation: Dashboard is default/home screen when app launches

---

### Story 2.6: Plant Selection Screen with Browse and Search

**As a** user,
**I want** to browse and search the plant database to assign a plant type to my device,
**so that** the app can compare sensor readings to the correct optimal ranges.

**Acceptance Criteria:**
1. Plant Selection screen UI created with:
   - Search bar at top (filter plants by name)
   - Category tabs or filter: All, Vegetables, Fruits, Herbs
   - Scrollable list of plants (name, thumbnail image placeholder, brief description)
   - Tap plant to view details modal/screen
2. Plant detail view shows:
   - Plant name, photo placeholder, scientific name
   - Optimal ranges (moisture %, light hours/lux, temperature °C)
   - "Assign to Device" button
3. Search functionality works: typing "tom" filters to tomato varieties
4. Category filter works: tapping "Herbs" shows only herb plants
5. Assign plant button (mock functionality - just closes modal for now, real assignment in Epic 4)

---

### Story 2.7: Chart Library Integration with Mock Sensor Data

**As a** user,
**I want** to see time-series charts of sensor readings over time,
**so that** I can identify trends and patterns in garden conditions (mock data initially).

**Acceptance Criteria:**
1. Chart library integrated (MPAndroidChart for Kotlin, or Microcharts/.NET MAUI Charts)
2. Historical Data screen created (accessible from dashboard via "View Charts" button)
3. 4 line charts displayed:
   - Soil Moisture (%) over time
   - Light (lux) over time
   - Air Temperature (°C) over time
   - Air Humidity (%) over time
4. Mock time-series data generated (last 7 days, readings every hour)
5. X-axis: Time (hourly ticks), Y-axis: Sensor value
6. Charts scroll/zoom (if library supports)
7. View toggle: 24 hours, 7 days (mock toggle buttons, both show same mock 7-day data for now)

---

### Story 2.8: Mobile App Distribution Strategy and Build Configuration

**As a** developer,
**I want** a documented strategy for building, signing, and distributing the Android app to users,
**so that** I can deploy the MVP to real users and iterate based on feedback.

**Acceptance Criteria:**
1. App signing configuration documented in `docs/app-distribution-guide.md`:
   - Generate release keystore for signing APKs (`keytool -genkey`)
   - Configure Gradle signing config for release builds (Kotlin) or .NET MAUI signing
   - Document keystore storage location and backup procedure (DO NOT commit keystore to Git)
2. Build process documented:
   - Debug build: `./gradlew assembleDebug` (Kotlin) or `dotnet build` (.NET MAUI)
   - Release build: `./gradlew assembleRelease` (Kotlin) or `dotnet publish` (.NET MAUI)
   - Output APK location: `mobile-app/app/build/outputs/apk/release/` (Kotlin)
3. MVP distribution strategy documented:
   - **Phase 1 (MVP):** Direct APK distribution via GitHub Releases
   - Users download APK, enable "Install from Unknown Sources", install manually
   - Release versioning: v1.0.0 (follows semantic versioning)
4. Post-MVP distribution options documented:
   - **Phase 4:** Google Play Store submission (requires Google Play Developer account - $25 one-time fee)
   - **Phase 4 (optional):** F-Droid open-source app store (free, aligns with open-source goals)
5. Version tracking added to mobile app:
   - App version displayed in Settings screen ("Version 1.0.0")
   - Version code incremented with each release
6. First release build created successfully:
   - Build and sign release APK
   - Install on test device, verify app runs correctly

**Notes:**
- MVP uses manual APK distribution (simple, no app store review delays)
- Google Play Store deferred to Phase 4 (after MVP validation with real users)
- F-Droid submission requires reproducible builds (research needed, defer to Phase 4)

---

**Epic 2 Complete:** You now have a mobile app that can browse 25 plants, display a dashboard with mock sensor data, and visualize charts. Ready for Bluetooth integration to replace mock data with real sensor readings.

---

## Epic 3: Bluetooth Sync & Data Integration

**Epic Goal:** Implement Bluetooth Low Energy communication between Raspberry Pi firmware and mobile app. By the end, you'll have end-to-end data flow: sensors → firmware → Bluetooth → mobile app → charts.

### Story 3.1: Bluetooth BLE Server on Raspberry Pi (Advertising and Connection)

**As a** Raspberry Pi device,
**I want** to advertise as a BLE peripheral and accept connections from the mobile app,
**so that** the app can discover and pair with the device.

**Acceptance Criteria:**
1. Python BLE library installed (`bluepy` or `bleak` - recommend `bleak` for async)
2. BLE server script `firmware/bluetooth_server.py` created with:
   - Device advertises as "OpenGardenLab-XXXX" (XXXX = last 4 digits of Pi MAC address)
   - Service UUID defined (custom UUID for OpenGardenLab)
   - Characteristic UUID for data sync (read/write)
3. BLE server runs continuously (alongside sensor sampling service, or integrated)
4. BLE server accepts connection from any BLE central device
5. Test: Use generic BLE scanner app (nRF Connect, LightBlue) to discover "OpenGardenLab" device, connect successfully

---

### Story 3.2: Bluetooth BLE Client in Mobile App (Device Discovery and Pairing)

**As a** mobile app user,
**I want** to scan for nearby OpenGardenLab devices and pair via Bluetooth,
**so that** I can connect my app to my garden monitoring device.

**Acceptance Criteria:**
1. Android Bluetooth permissions requested (BLUETOOTH, BLUETOOTH_ADMIN, ACCESS_FINE_LOCATION for BLE scan)
2. Device Discovery screen created with:
   - "Scan for Devices" button
   - List of discovered BLE devices (name "OpenGardenLab-XXXX", signal strength)
   - Tap device to pair/connect
3. BLE scan functionality implemented:
   - Scans for devices advertising OpenGardenLab service UUID
   - Displays device name and signal strength (RSSI)
4. Connect to device:
   - Taps device in list → initiates BLE connection
   - Connection success/failure feedback (toast or dialog)
5. Paired device saved to app local storage (device ID, name, last connected timestamp)
6. Test: Scan discovers Pi device, connect succeeds, device added to app's paired device list

---

### Story 3.3: Data Sync Protocol (JSON Message Format)

**As a** system architect,
**I want** a defined JSON message format for syncing sensor data over Bluetooth,
**so that** firmware and mobile app can communicate reliably.

**Acceptance Criteria:**
1. Protocol documented in `docs/bluetooth-protocol.md` with message schemas:
   - **Request from app:** `{"type": "get_readings", "since": "2025-10-01T12:00:00Z"}` (ISO timestamp)
   - **Response from device:** `{"type": "readings", "data": [{"timestamp": "...", "soil_moisture": 45.2, ...}, ...]}`
   - **Device info request:** `{"type": "get_device_info"}`
   - **Device info response:** `{"type": "device_info", "device_id": "...", "firmware_version": "1.0"}`
2. Firmware Bluetooth server implements message handling:
   - Receives JSON string via BLE write characteristic
   - Parses JSON, executes query (e.g., `get_readings_since(timestamp)`)
   - Responds with JSON string via BLE read characteristic or notification
3. Mobile app implements message sending:
   - Constructs JSON request
   - Sends via BLE write, waits for response
   - Parses JSON response
4. Protocol handles large payloads (30 days of readings = ~3,000 data points):
   - Option 1: Chunked transfer (send in batches)
   - Option 2: Compression (gzip JSON before BLE transfer)
5. Test: Send "get_device_info" from app, receive valid device info JSON from Pi

---

### Story 3.4: Firmware - Bluetooth Data Sync Handler

**As a** Raspberry Pi firmware,
**I want** to respond to mobile app sync requests by querying SQLite and sending sensor data,
**so that** the app receives up-to-date sensor readings.

**Acceptance Criteria:**
1. Bluetooth sync handler integrated into `firmware/bluetooth_server.py` or separate module
2. Handler processes "get_readings" requests:
   - Parses `since` timestamp from request JSON
   - Calls `storage.get_readings_since(since_timestamp)`
   - Converts query results to JSON response (list of readings)
   - Sends JSON back to mobile app via BLE
3. Handler processes "get_device_info" requests:
   - Returns device_id (Pi MAC or unique ID), firmware version, storage stats
4. Large payloads handled (3,000+ readings):
   - If JSON response > 512 bytes, split into chunks (BLE MTU limitation)
   - OR compress with gzip, send compressed bytes
5. Test: Request readings since "1 week ago", verify all readings transferred successfully

---

### Story 3.5: Mobile App - Bluetooth Data Sync and Local Storage

**As a** mobile app,
**I want** to request sensor data from the Pi device via Bluetooth and store it locally,
**so that** users can view data offline even when not connected to the device.

**Acceptance Criteria:**
1. Mobile app local SQLite database created (Room for Kotlin, SQLite.NET for .NET MAUI)
2. Database schema mirrors firmware schema (sensor_readings table)
3. Sync function implemented:
   - Determine last synced timestamp from local DB
   - Send BLE request: `get_readings since last_synced_timestamp`
   - Receive JSON response, parse readings
   - Insert new readings into local DB
   - Update "last synced" timestamp
4. Sync initiated from Dashboard screen "Sync" button:
   - Button shows loading spinner during sync
   - Success/failure feedback (toast: "Synced 120 new readings" or "Sync failed")
5. Sync tested: 7 days of data (700+ readings) syncs in < 5 minutes, all data stored locally

---

### Story 3.6: Dashboard and Charts Display Real Sensor Data

**As a** user,
**I want** the dashboard and charts to display real sensor data from my device,
**so that** I can see actual garden conditions instead of mock data.

**Acceptance Criteria:**
1. Dashboard screen updated to query local DB for latest sensor reading (replaces mock data)
2. Sensor readings displayed: soil moisture, light lux, air temp, air humidity (from synced data)
3. If no data available (new device, never synced), show "Sync device to view data" message
4. Historical charts screen updated to query local DB for time-series data:
   - Query last 24 hours / 7 days / 30 days of readings
   - Plot real data on line charts
5. Chart X-axis shows actual timestamps, Y-axis shows actual sensor values
6. Test: Sync device, dashboard shows real readings, charts show real trends

---

### Story 3.7: Multi-Device Support (Device List and Switcher)

**As a** user with multiple garden zones,
**I want** to pair multiple devices and switch between them in the app,
**so that** I can monitor different garden beds independently.

**Acceptance Criteria:**
1. Device List screen created:
   - List of paired devices (name, last synced, connection status)
   - Tap device to switch to it (makes it "active device")
   - "Add Device" button → opens Device Discovery screen (from Story 3.2)
2. Active device concept:
   - App tracks currently selected device (stored in local settings)
   - Dashboard shows data for active device only
   - Charts show data for active device only
3. Device switcher on Dashboard (dropdown or swipe gesture):
   - Quick switch between paired devices without navigating to Device List
4. Each device has independent data in local DB (device_id column added to readings table)
5. Test: Pair 2 devices, sync both, switch between them, verify dashboard shows correct device's data

---

**Epic 3 Complete:** You now have full Bluetooth sync working. Sensor data flows from Pi to mobile app, displays on dashboard and charts. Multi-device support allows monitoring multiple garden zones.

---

## Epic 4: Recommendations Engine & Multi-Device Support

**Epic Goal:** Generate actionable plant care recommendations and add final MVP features (garden journal, device settings, calibration). By the end, OpenGardenLab delivers its core value: helping gardeners make data-driven decisions.

### Story 4.1: Recommendation Logic (Compare Actual vs Optimal Ranges)

**As a** mobile app,
**I want** to compare sensor readings to assigned plant's optimal ranges and generate insights,
**so that** users receive actionable guidance on plant care.

**Acceptance Criteria:**
1. Recommendation engine module created (`RecommendationEngine` class or similar)
2. Logic implemented for each sensor type:
   - **Soil Moisture:** Calculate average over last 7 days, compare to plant's optimal range (min/max %)
   - **Light:** Calculate average daily lux hours, compare to plant's required hours/day
   - **Temperature:** Check if current temp is within plant's optimal range
   - **Humidity:** Check if current humidity is within plant's optimal range
3. Generate recommendations:
   - If moisture < optimal min: "Soil is drier than optimal. Water more frequently."
   - If light < optimal hours: "Plant is receiving less sun than needed. Consider relocating."
   - If temp < optimal min: "Temperatures are below optimal. Provide frost protection or wait to plant."
4. Severity levels: Good (green), Caution (yellow), Alert (red)
5. Unit tests validate logic with mock readings and plant profiles

---

### Story 4.2: Recommendations Screen with Actionable Guidance

**As a** user,
**I want** a dedicated screen showing all current recommendations and trend-based insights,
**so that** I know exactly what actions to take to improve plant health.

**Acceptance Criteria:**
1. Recommendations screen created (accessible from Dashboard via "View Recommendations" button)
2. Screen displays list of recommendations:
   - Icon + severity color (green/yellow/red)
   - Recommendation text (e.g., "Soil moisture is 15% below optimal")
   - Suggested action (e.g., "Water 1-2 cups daily until moisture reaches 40-60%")
   - Timestamp of analysis ("Based on last 7 days of data")
3. Trend insights included:
   - "Moisture has dropped 20% over last 3 days" (if applicable)
   - "Light hours increasing (spring growth period)" (if applicable)
4. If no assigned plant, show: "Assign a plant to receive recommendations"
5. If no recommendations (all readings optimal), show: "Your plants are thriving! All conditions are optimal."
6. Test: Assign plant, sync data with suboptimal moisture, verify recommendation appears

---

### Story 4.3: Dashboard Integration of Recommendations

**As a** user,
**I want** the dashboard to show a summary of recommendations,
**so that** I see key issues immediately without navigating to separate screen.

**Acceptance Criteria:**
1. Dashboard updated with "Recommendations" section:
   - Show top 2 most critical recommendations (highest severity)
   - Compact card format (icon, title, brief description)
   - "View All" button → navigates to Recommendations screen
2. Color-coded status banner at top of dashboard:
   - Green: "All good! Plants are thriving"
   - Yellow: "2 cautions - review recommendations"
   - Red: "3 alerts - action needed"
3. If no plant assigned, banner shows: "Assign plant to receive insights"
4. Test: Dashboard shows correct recommendations based on synced data and assigned plant

---

### Story 4.4: Garden Journal (Note-Taking Feature)

**As a** user,
**I want** to add timestamped notes about garden observations and actions taken,
**so that** I can track what I've done and correlate it with sensor data.

**Acceptance Criteria:**
1. Garden Journal screen created (accessible from main navigation or dashboard)
2. Journal displays chronological list of entries:
   - User notes: "Watered 2 cups", "Added fertilizer", "Noticed yellowing leaves"
   - Auto-generated entries: "Device synced", "Plant assigned: Cherry Tomato"
   - Timestamp for each entry
3. "Add Note" button opens text input dialog:
   - User types note, taps "Save"
   - Entry added with current timestamp and device ID (attached to active device)
4. Filter options:
   - View all notes across all devices
   - Filter by specific device
   - Filter by date range (last 7 days, 30 days, etc.)
5. Local storage: Notes saved in SQLite table (`journal_entries`)
6. Test: Add 5 notes, switch devices, verify notes are correctly associated with devices

---

### Story 4.5: Device Settings - Sampling Interval Configuration

**As a** user,
**I want** to configure how often the device samples sensors,
**so that** I can balance battery life vs data granularity.

**Acceptance Criteria:**
1. Device Settings screen created (accessible from Dashboard "Settings" button or device list)
2. Setting: Sampling Interval
   - Dropdown or slider: 15 minutes, 30 minutes, 60 minutes
   - Current value displayed
   - "Save" button sends new interval to device via Bluetooth
3. Bluetooth protocol extended with "set_config" message:
   - Request: `{"type": "set_config", "sampling_interval_minutes": 30}`
   - Response: `{"type": "config_updated", "success": true}`
4. Firmware receives config update, writes to `firmware/config.yaml`, restarts sampling loop with new interval
5. Test: Change interval from 15min to 60min, verify firmware logs show new interval after sync

---

### Story 4.6: Device Settings - Soil Moisture Calibration

**As a** user,
**I want** to calibrate the soil moisture sensor for accurate readings,
**so that** moisture percentages reflect true soil conditions.

**Acceptance Criteria:**
1. Calibration wizard added to Device Settings:
   - Step 1: "Remove sensor from soil and let dry completely. Tap Next when ready."
   - Step 2: Device samples sensor, records "air reading" (0% moisture)
   - Step 3: "Submerge sensor tip in water (don't submerge electronics!). Tap Next when ready."
   - Step 4: Device samples sensor, records "water reading" (100% moisture)
   - Step 5: Calibration values sent to firmware, saved to config
2. Bluetooth protocol extended with calibration messages:
   - Request air reading: `{"type": "get_calibration_reading", "sensor": "soil_moisture"}`
   - Response: `{"type": "calibration_reading", "value": 200}`
   - Save calibration: `{"type": "set_calibration", "air_value": 200, "water_value": 1023}`
3. Firmware updates `config.yaml` with calibration values, applies to all future sensor readings
4. Test: Run calibration, verify subsequent moisture readings are in sensible 0-100% range

---

### Story 4.7: Device Settings - View Device Info

**As a** user,
**I want** to view device information (ID, firmware version, storage stats),
**so that** I can troubleshoot issues and know device status.

**Acceptance Criteria:**
1. Device Info section in Device Settings displays:
   - Device ID (Pi MAC address or unique identifier)
   - Device name/label (editable)
   - Firmware version (e.g., "1.0.0")
   - Storage: "1,234 readings stored (12.5 MB used, 28 days of data)"
   - Last synced timestamp
   - Battery/power status (if detectable - optional MVP feature)
2. "Edit Device Name" button allows renaming (e.g., "Tomato Bed" → "Front Yard Tomatoes")
3. Device info retrieved via Bluetooth "get_device_info" message (from Story 3.3)
4. Test: View device info, verify all fields display correctly

---

**Epic 4 Complete:** OpenGardenLab MVP is fully functional! Users can monitor multiple garden zones, receive data-driven plant care recommendations, journal observations, and configure device settings. All core value delivered.

---

## Next Steps

### Immediate Actions (Start MVP Development)

1. **Order Hardware** (Week 1)
   - Purchase Raspberry Pi Zero 2 W, sensors (STEMMA Soil, BH1750, DHT20, DS18B20), power banks, MicroSD, enclosure
   - Budget: ~$100-120 per device
   - Estimated delivery: 1-2 weeks

2. **Begin Epic 1 - Foundation & Firmware** (Weeks 2-4)
   - Set up repository structure (Story 1.1)
   - Flash Raspberry Pi OS, configure SSH (Story 1.2)
   - While waiting for sensors: research Adafruit libraries, study example code
   - Once hardware arrives: wire sensors, validate readings (Stories 1.3-1.5)
   - Build sensor sampling service and storage (Stories 1.6-1.9)
   - **Milestone:** Autonomous sensor device logging data 24/7

3. **Architecture Design Phase** (Parallel with Epic 1)
   - **Next:** Architect agent creates detailed architecture document
   - Decisions to finalize:
     - Mobile app framework: Kotlin native vs .NET MAUI (consult with architect)
     - SQLite vs TinyDB for firmware storage
     - Bluetooth library: bluepy vs bleak
   - Output: [architecture.md](architecture.md) document

4. **Plant Database Curation** (Weeks 3-8, parallel with development)
   - Start with 5-10 most common plants (tomato, pepper, basil, lettuce, etc.)
   - Research optimal ranges from university extension guides
   - Document in YAML format
   - Incrementally grow to 25 plants for MVP

---

### Post-MVP: Future Phases

**Phase 2: Advanced Diagnostics & Expanded Plant Database**
- Diagnostic rules engine: correlate symptoms with sensor patterns
  - "Yellowing leaves + high moisture + low light = overwatering or insufficient sun"
- Expand plant database to 50-100 plants via community contributions
- Camera module integration for visual plant health monitoring (optional)

**Phase 3: Additional Sensors & Multi-Node Architecture**
- Soil NPK sensor (nitrogen, phosphorus, potassium)
- Soil pH sensor
- Multi-device architecture: ESP32 sensor nodes → Raspberry Pi hub → mobile app
- Solar panel + battery management for true off-grid deployment

**Phase 4: Community & Ecosystem**
- Open-source release on GitHub
- Plant database contribution guidelines
- Web dashboard (view sensor data from desktop browser)
- Export data to CSV for analysis in Excel/Python

**Phase 5: Advanced Analytics & ML**
- Predictive modeling: "Moisture will hit 0% in 2 days if not watered"
- Regional plant recommendations based on collected sensor data
- Integration with weather APIs for context-aware recommendations

---

## Success Metrics for MVP

**Technical Success:**
- [ ] Firmware samples sensors continuously for 7+ days without crashes or data loss
- [ ] Bluetooth sync transfers 30 days of data (3,000+ readings) in < 5 minutes
- [ ] Mobile app displays sensor data with < 2 second screen load time
- [ ] Battery life: 7+ days on 20,000mAh power bank
- [ ] Sensor accuracy meets NFR3 targets (moisture ±5%, light ±20%, temp ±1°C)

**User Value:**
- [ ] Plant database includes 25+ common garden plants with scientifically cited optimal ranges
- [ ] Recommendations are actionable and specific (not generic "water more")
- [ ] User can identify and resolve plant problems faster than trial-and-error (qualitative feedback)

**Learning Goals:**
- [ ] Developer gains hands-on experience with I2C/1-Wire sensors, Python GPIO programming
- [ ] Developer completes first end-to-end IoT project (hardware + firmware + mobile app)
- [ ] Developer builds confidence for future IoT projects (ESP32, LoRa, solar power, etc.)

**Project Completion:**
- [ ] All 4 epics delivered (33 stories completed)
- [ ] MVP deployed in real garden environment, monitoring actual plants
- [ ] Documentation complete (README, architecture, setup guides)
- [ ] GitHub repository published as open-source

---

## Risks and Mitigation

| **Risk** | **Impact** | **Likelihood** | **Mitigation** |
|----------|-----------|----------------|----------------|
| **Bluetooth range insufficient** (< 30 feet) | High - renders device unusable indoors | Medium | Test Bluetooth range early (Story 3.1). If inadequate, add WiFi fallback or BLE range extender |
| **Battery life < 7 days** | Medium - frequent charging annoying | Medium | Optimize sampling interval (start with 30min instead of 15min). Add solar panel in Phase 2 if needed |
| **Sensor corrosion in outdoor environment** | Medium - sensor failure after months | Medium | Use capacitive sensors (not resistive). Test sensors outdoors for 1-2 months before full deployment |
| **Mobile app framework choice (Kotlin vs .NET MAUI) causes delays** | Medium - learning curve if unfamiliar | Low | Decide in Epic 2 Story 2.1 based on quick prototype (2-3 days testing both) |
| **Plant database curation takes longer than expected** | Low - can ship with fewer plants | Medium | Start with 10 plants instead of 25 for initial release. Expand incrementally |
| **Scope creep - adding features beyond MVP** | High - delays launch | High | Strictly defer non-MVP features to Phase 2+. Use PRD as scope gate (if not in Epic 1-4, it's out) |

---

## Appendix: Story Count and Effort Estimates

### Epic Breakdown

| **Epic** | **Stories** | **Estimated Effort** | **Dependencies** |
|----------|-------------|----------------------|------------------|
| Epic 1: Foundation & Firmware | 11 stories | 3-4 weeks | Hardware arrival |
| Epic 2: Mobile App & Plant DB | 8 stories | 3-4 weeks | None (can start parallel with Epic 1) |
| Epic 3: Bluetooth Sync | 7 stories | 2-3 weeks | Epics 1 & 2 complete |
| Epic 4: Recommendations & Final Features | 7 stories | 2-3 weeks | Epic 3 complete |
| **Total** | **33 stories** | **10-14 weeks** (part-time, solo developer) | |

### Parallel Development Strategy

To optimize timeline, some epics can run in parallel:

**Weeks 1-4:**
- Epic 1 (firmware) on Raspberry Pi
- Epic 2 (mobile app) on development PC
- Plant database curation (5-10 plants)

**Weeks 5-7:**
- Epic 3 (Bluetooth integration)

**Weeks 8-10:**
- Epic 4 (recommendations, final polish)

**Estimated MVP completion:** 10-12 weeks part-time (15-20 hours/week)

---

## Document History

**v1.0 - 2025-10-02**
- Initial PRD creation
- All 4 epics defined with 33 user stories (including CI/CD, firmware updates, and app distribution)
- Requirements, UI/UX design goals, technical assumptions documented
- Based on completed Phase 1 research (hardware, sensors, plant database)

---

**PRD Complete.** Next: Architecture agent designs system architecture informed by this PRD.

