# Technical Assumptions

## Repository Structure

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

## Service Architecture

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

## Testing Requirements

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

## Additional Technical Assumptions and Requests

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
