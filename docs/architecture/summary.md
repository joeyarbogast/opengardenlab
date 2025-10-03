# Summary

OpenGardenLab is a **local-first IoT garden monitoring system** with a unique architecture optimized for educational learning, data ownership, and offline operation. Key architectural highlights:

## Technical Foundation
- **Hardware:** Raspberry Pi Zero 2 W + 4 I2C/1-Wire sensors ($121/device)
- **Firmware:** Python monolith (sensor sampling, SQLite storage, BLE server)
- **Mobile:** Android app with MVVM architecture, offline-first design
- **Communication:** Bluetooth LE with JSON protocol (no cloud required)

## Architectural Patterns
- **Local-first:** All data stored on device + mobile app, no internet dependency
- **Repository Pattern:** Abstract data sources (SQLite, Bluetooth, JSON)
- **MVVM:** Clean separation of UI, business logic, and data access
- **Offline-capable:** App works fully without device connection

## Key Design Decisions
- **Python over C++** for firmware (faster development, easier debugging)
- **Android-only** (iOS $99/year App Store fee is prohibitive for open-source)
- **SQLite everywhere** (embedded database, perfect for single-device use)
- **No authentication** (MVP security model: physical proximity required)
- **Monorepo** (single Git repo for firmware + mobile + plant database)

## Development Workflow
- **Solo developer friendly:** 10-14 weeks part-time for MVP
- **GitHub Actions CI/CD:** Automated testing and APK builds
- **Open-source distribution:** APK via GitHub Releases (free, no vendor lock-in)

## Next Steps
1. Complete Phase 2.2: Architecture (this document) ✅
2. Begin Epic 1: Firmware development (Stories 1.1-1.9)
3. Parallel: Plant database curation (25+ plants)
4. Epic 2: Mobile app foundation
5. Epic 3: Bluetooth integration
6. Epic 4: Recommendations & final features

**Architecture document complete.** Ready to guide AI-driven development across all 30 user stories.

---

**END OF ARCHITECTURE DOCUMENT**

