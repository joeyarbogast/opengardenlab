# Tech Stack

This table is the **definitive technology selection** for OpenGardenLab. All development must use these exact versions and tools.

| **Category** | **Technology** | **Version** | **Purpose** | **Rationale** |
|--------------|----------------|-------------|-------------|---------------|
| **Firmware Language** | Python | 3.9+ | Raspberry Pi firmware development | Accessible from .NET background, rich IoT libraries (Adafruit CircuitPython), rapid prototyping, excellent debugging via SSH |
| **GPIO Library** | Adafruit CircuitPython | Latest | I2C/1-Wire sensor communication | Well-documented, beginner-friendly, official Adafruit support for all chosen sensors |
| **Bluetooth Library** | bleak | 0.21+ | BLE server on Raspberry Pi | Async Python BLE library, cross-platform, actively maintained, simpler than bluepy |
| **Firmware Database** | SQLite | 3.x (built-in) | Local sensor data storage | Built-in to Python, lightweight, no server needed, perfect for embedded use |
| **Firmware Config** | PyYAML | 6.0+ | Read/write device config files | Human-readable config (calibration, sampling interval), easy to edit via SSH |
| **Firmware Logging** | Python logging | 3.9+ (built-in) | Structured logging to file | Built-in, rotating file handler, SSH-accessible logs for debugging |
| **Mobile Platform** | Android | 8.0+ (API 26) | Mobile app platform | Developer has Android device, BLE APIs well-supported from API 26, large user base |
| **Mobile Language** | Kotlin | Latest | Android native mobile app development | Native Android performance, full BLE API access, mature ecosystem. Android-only (iOS not considered due to $99/year App Store requirement and no sideloading support) |
| **Mobile Database** | SQLite (Room) | Latest | Local sensor data cache | Mirrors firmware schema, offline-first architecture, well-integrated with Android |
| **Mobile Charts** | MPAndroidChart | Latest | Time-series sensor data visualization | Popular Android charting library, supports line charts with zoom/pan |
| **Plant Database Format** | YAML → JSON | N/A | Human-editable plant profiles | YAML for Git-friendly editing with citations, compiled to JSON for mobile app bundle |
| **Version Control** | Git + GitHub | Latest | Source code management | Industry standard, supports open-source distribution, GitHub Actions for CI/CD |
| **Firmware Testing** | pytest | 7.x+ | Unit tests for sensor logic | Standard Python testing framework, mocking support for I2C sensors |
| **Mobile Testing** | JUnit/Espresso | Latest | Unit + UI tests for mobile app | Standard Android testing framework (JUnit for unit tests, Espresso for UI tests) |
| **Build Tool (Firmware)** | systemd | N/A | Autostart firmware on Pi boot | Built-in to Raspberry Pi OS, reliable service management |
| **Build Tool (Mobile)** | Gradle | Latest | Android app build/package | Standard Android build system, integrates with Android Studio |
| **CI/CD** | GitHub Actions | N/A | Automated testing + build | Free for open-source, runs pytest for firmware, builds mobile app, validates plant YAML |
| **Monitoring (Firmware)** | Log files + SSH | N/A | Manual log inspection during development | Simple logging to `/home/pi/firmware/logs/`, tail via SSH for debugging |
| **Monitoring (Mobile)** | Logcat (development only) | N/A | Android debug logs during development | Standard Android logging, no production telemetry (privacy-first) |
| **Deployment (Firmware)** | Manual SD card flash + SSH config | N/A | Initial setup: flash Pi OS, copy firmware, enable systemd service | No OTA updates in MVP (future consideration) |
| **Deployment (Mobile)** | APK via GitHub Releases | N/A | Open-source APK distribution | Free APK download from GitHub releases, users sideload to Android devices. Post-MVP: F-Droid (open-source app store) or Google Play ($25 one-time) |

## Key Technology Decisions

**1. Python for Firmware (not C/C++)**
- **Pros:** Faster development, easier debugging, extensive library support, accessible to .NET developers
- **Cons:** Slightly higher power consumption than C/C++, slower execution
- **Decision:** MVP prioritizes learning and rapid iteration over maximum efficiency. Python's development speed and debugging capabilities outweigh performance concerns for 15-minute sampling intervals.

**2. Kotlin for Android Mobile App**

**Why Android-only:**
- **iOS distribution is impractical for open-source hardware projects:** Apple requires $99/year App Store fee with no free alternative (no sideloading). Android allows free APK distribution via GitHub Releases or F-Droid.
- **Target audience:** Home gardeners building IoT hardware are more likely Android users (tinkerer demographic).
- **Budget:** Zero ongoing costs for MVP (APK distribution is free).

**Why Kotlin:**
- **Native Android performance:** No cross-platform overhead, optimal performance
- **Full BLE API access:** Complete control over Bluetooth Low Energy communication
- **Mature ecosystem:** Industry standard for Android development, extensive libraries and tooling
- **Strong community support:** Large developer community, extensive documentation
- **Excellent tooling:** First-class support in Android Studio
- **Modern language features:** Coroutines for async operations, null safety, concise syntax

**Decision:** Use Kotlin for native Android development. No prototyping phase needed - Kotlin is the clear choice for Android-only IoT applications requiring Bluetooth LE.

**3. SQLite for All Storage (not PostgreSQL, MongoDB, etc.)**
- **Rationale:** Local-first architecture requires embedded database. SQLite is battle-tested, built-in to Python and Android, zero-configuration, perfect for single-device use. No need for client-server databases.

**4. Bluetooth Low Energy (not WiFi HTTP API)**
- **Rationale:** Eliminates need for home WiFi infrastructure, router configuration, or cloud backend. BLE works in gardens without WiFi coverage. Aligns with local-first, privacy-focused design.

**5. No Cloud Platform (not AWS, Azure, GCP)**
- **Rationale:** MVP focuses on fundamentals. Cloud adds complexity (auth, scaling, billing) that distracts from learning IoT basics. Post-MVP can add optional cloud sync for remote access.

**6. Android APK Distribution via GitHub Releases (not App Stores)**
- **Rationale:** Open-source hardware projects expect users to build/sideload. GitHub Releases provides free hosting for APK artifacts. Users enable "Install from Unknown Sources" on Android (standard for open-source apps). Post-MVP options: F-Droid (free, popular with FOSS community) or Google Play ($25 one-time if desired).

---
