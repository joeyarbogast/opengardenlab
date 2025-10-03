# High-Level Architecture

## Technical Summary

OpenGardenLab is a **distributed embedded system** consisting of three major components:

1. **Raspberry Pi Zero 2 W firmware** (Python) - Autonomous sensor data collection and local storage, operating continuously in garden environments with weekly power bank swaps.

2. **Android mobile app** (Kotlin) - Offline-capable interface for viewing sensor data, receiving plant care recommendations, and managing multiple garden zones.

3. **Bluetooth Low Energy (BLE) communication** - On-demand sync protocol allowing mobile app to retrieve sensor data when user is within range (~30-100 feet), eliminating need for WiFi infrastructure or cloud services.

The system uses a **local-first, offline-first architecture** where each component operates independently: firmware samples sensors every 15-60 minutes regardless of app connectivity, app displays cached data and recommendations without internet, and data synchronization occurs opportunistically via Bluetooth when devices are in proximity.

This architecture achieves PRD goals by:
- **Providing actionable recommendations** through local comparison of sensor readings vs plant-specific optimal ranges
- **Enabling learning** through accessible Python firmware and well-documented Android development
- **Supporting future expansion** with modular sensor interfaces and extensible mobile app architecture
- **Maintaining data ownership** by storing all sensor data locally on device and in mobile app (no cloud lock-in)

## Platform and Infrastructure

**Platform:** Hybrid embedded/mobile (no traditional cloud infrastructure)

**Key Components:**
- **Edge Device:** Raspberry Pi Zero 2 W (ARM Cortex-A53, 512MB RAM)
- **Mobile Platform:** Android 8.0+ (API 26)
- **Communication:** Bluetooth Low Energy 4.2+
- **Storage:** Local SQLite databases (device + mobile app)
- **Power:** Swappable USB power banks (MVP), solar charging (post-MVP)

**No cloud services required for MVP.** The system is designed to operate entirely offline:
- No authentication servers (single-user app, device pairing only)
- No remote data storage (all data local)
- No API gateways or load balancers
- No CDN or caching layers

**Deployment "Regions":** User's home garden (typically 1-3 devices per household)

**Rationale:** This architecture prioritizes **data ownership, privacy, and independence** over convenience features like remote access. It also significantly reduces operating costs (no monthly cloud fees) and complexity (no API management, no distributed system debugging). The local-first approach aligns with the learning goals of understanding fundamental IoT patterns before adding cloud abstractions.

---
