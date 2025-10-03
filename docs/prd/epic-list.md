# Epic List

This section provides a high-level overview of the major epics for OpenGardenLab MVP. Each epic delivers a significant, end-to-end increment of testable functionality. Epics are sequenced to ensure each builds upon the foundation of previous work.

## Epic 1: Foundation & Core Firmware
**Goal:** Establish project infrastructure, Raspberry Pi setup, and basic sensor data collection.

This epic delivers the foundational firmware that can read sensors and store data locally. By the end of this epic, you'll have a working Raspberry Pi device that samples sensors every N minutes and logs data, even though there's no mobile app yet. This validates hardware integration and provides a solid base for Bluetooth sync.

**Key deliverables:**
- Git repository structure (monorepo)
- Raspberry Pi OS setup with Python environment
- Sensor sampling service (reads STEMMA Soil, BH1750, DHT20, DS18B20)
- Local data storage (SQLite or TinyDB)
- Logging and basic health check (LED blink or console output)

---

## Epic 2: Mobile App Foundation & Plant Database
**Goal:** Create Android mobile app structure, load plant database, and implement core UI screens (dashboard, plant selection).

This epic establishes the mobile app skeleton with navigation, plant database integration, and basic UI. By the end, you'll have an app that can browse plants and view dummy sensor data, setting the stage for Bluetooth sync integration.

**Key deliverables:**
- Android app project setup (Kotlin or .NET MAUI)
- Plant database (YAML → JSON, bundled with app)
- Device Dashboard screen (mock data initially)
- Plant Selection screen (browse/search 50+ plants)
- Data visualization library integration (charts - mock data)

---

## Epic 3: Bluetooth Sync & Data Integration
**Goal:** Implement Bluetooth communication between Raspberry Pi firmware and mobile app, enabling device pairing and data synchronization.

This epic is the critical integration point that connects firmware and mobile app. By the end, you'll have a fully functional end-to-end system: sensors → firmware → Bluetooth → mobile app → charts & recommendations.

**Key deliverables:**
- Bluetooth BLE server on Raspberry Pi (Python bluepy/bleak)
- Bluetooth BLE client in mobile app (Android APIs)
- Device pairing and discovery flow
- Data sync protocol (JSON messages)
- Real sensor data displayed in mobile app (replacing mock data)

---

## Epic 4: Recommendations Engine & Multi-Device Support
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
