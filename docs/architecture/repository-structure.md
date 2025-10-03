# Repository Structure

**Monorepo** - Single Git repository containing all OpenGardenLab components.

**Rationale:**
- Easier to keep firmware, mobile app, and plant database synchronized
- Atomic commits across components (e.g., Bluetooth protocol change + app update in one commit)
- Simpler for solo developer (one repo to clone, one CI/CD pipeline)
- Shared documentation in one place

**Structure:**

```
opengardenlab/
├── .github/
│   └── workflows/
│       ├── firmware-tests.yml        # pytest for Python firmware
│       ├── mobile-tests.yml          # Android unit tests
│       └── plant-db-validation.yml   # Validate YAML schema
├── firmware/                         # Raspberry Pi Python firmware
│   ├── src/
│   │   ├── sensor_service.py         # Main sampling loop
│   │   ├── sensors/                  # Sensor drivers
│   │   │   ├── stemma_soil.py
│   │   │   ├── bh1750_light.py
│   │   │   ├── dht20_temp_humid.py
│   │   │   └── ds18b20_temp.py
│   │   ├── storage.py                # SQLite data access layer
│   │   ├── bluetooth_server.py       # BLE server + protocol
│   │   └── config.py                 # YAML config loader
│   ├── data/                         # Runtime data directory
│   │   └── sensor_data.db            # SQLite database (created at runtime)
│   ├── logs/                         # Log files (created at runtime)
│   ├── tests/                        # pytest unit tests
│   │   ├── test_sensors.py
│   │   ├── test_storage.py
│   │   └── test_bluetooth.py
│   ├── config.yaml                   # Device configuration (calibration, sampling interval)
│   ├── requirements.txt              # Python dependencies
│   └── README.md                     # Firmware setup guide
├── mobile-app/                       # Android application
│   ├── app/                          # Main app module (Kotlin)
│   │   ├── src/
│   │   │   ├── main/
│   │   │   │   ├── java/com/opengardenlab/
│   │   │   │   │   ├── ui/          # UI screens (Dashboard, Charts, Settings)
│   │   │   │   │   ├── data/        # Local DB, repositories
│   │   │   │   │   ├── bluetooth/   # BLE client
│   │   │   │   │   ├── models/      # Data models
│   │   │   │   │   └── recommendations/ # Recommendation engine
│   │   │   │   ├── assets/          # plants.json bundled here
│   │   │   │   └── AndroidManifest.xml
│   │   │   └── test/                # Unit tests
│   │   ├── build.gradle
│   │   └── README.md
│   └── build.gradle (root)
├── plant-database/                   # YAML plant profiles
│   ├── schema/
│   │   └── plant-schema.yaml         # JSON schema for validation
│   ├── vegetables/
│   │   ├── tomato-cherry.yaml
│   │   ├── pepper-bell.yaml
│   │   └── ...
│   ├── herbs/
│   │   ├── basil.yaml
│   │   ├── cilantro.yaml
│   │   └── ...
│   ├── fruits/
│   │   ├── strawberry.yaml
│   │   └── ...
│   └── README.md                     # Plant data curation guide
├── scripts/
│   ├── compile-plants.py             # YAML → JSON compiler
│   └── validate-plants.sh            # CI validation script
├── docs/                             # All project documentation
│   ├── prd.md
│   ├── architecture.md               # This file
│   ├── project-brief.md
│   ├── technical-feasibility.md
│   ├── sensor-selection.md
│   ├── plant-database-research.md
│   ├── hardware-platform-research.md
│   ├── bluetooth-protocol.md         # To be created in Epic 3
│   └── workflow-plan.md
├── .gitignore
├── LICENSE                           # MIT or Apache 2.0
└── README.md                         # Project overview, quick start
```

**Package Management:**
- **Firmware:** `requirements.txt` for pip dependencies
- **Mobile:** Gradle (Kotlin)
- **No monorepo tool needed** - simple enough for manual coordination

---
