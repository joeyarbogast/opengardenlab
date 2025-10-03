# Technical Feasibility Summary: OpenGardenLab
**Architect:** Winston
**Date:** 2025-10-01
**Status:** Final
**Project:** OpenGardenLab IoT Garden Monitoring System

---

## Executive Summary

This document consolidates all Phase 1 research findings and provides a comprehensive technical feasibility assessment for OpenGardenLab MVP. Based on hardware platform, sensor selection, and plant database research, **the MVP is technically feasible and achievable within the stated constraints**.

### Feasibility Verdict: ✅ **FEASIBLE**

**Key validations:**
- ✅ Hardware platform identified (Raspberry Pi Zero 2 WH)
- ✅ Sensors selected and available ($23-33 per device)
- ✅ Plant data sources identified (university extension guides)
- ✅ Development timeline realistic (7-10 weeks firmware, parallel with app)
- ✅ Budget achievable ($87-120 per device)
- ✅ Technical complexity manageable for solo developer with .NET background
- ✅ All components support local-first, offline-capable architecture

### Critical Success Factors Validated

**1. Developer Experience Prioritization**
- Selected Python on Raspberry Pi (easy learning curve from .NET)
- Full debugging tooling available (SSH, REPL, remote development)
- 7-10 week timeline to working prototype vs. 12-16 weeks with ESP32/C++

**2. Local-First Architecture Achievable**
- All sensors work via I2C/GPIO (no internet required)
- Plant database bundled with mobile app (YAML → JSON)
- Bluetooth sync for mobile app (no cloud dependency)
- Swappable battery strategy for 150-foot distance from house

**3. MVP Scope Well-Defined**
- Core measurements: soil moisture, light, air temp/humidity (4 measurements)
- 25-50 plant profiles for launch (manageable curation effort)
- Basic recommendations (actual vs. optimal ranges)
- Post-MVP features clearly deferred (diagnostics, camera, NPK sensors)

---

## Hardware Platform: Final Decision

### Selected Platform: Raspberry Pi Zero 2 WH

**Model:** Raspberry Pi Zero 2 WH (Wireless + Headers pre-soldered)
**Cost:** $16-20

**Specifications:**
- **CPU:** Quad-core ARM Cortex-A53 @ 1GHz
- **RAM:** 512MB
- **Storage:** MicroSD (16-32GB recommended)
- **Wireless:** WiFi 2.4GHz + Bluetooth 4.2
- **GPIO:** 40-pin header (pre-soldered)
- **Power:** 5V via Micro-USB (0.4-1.4W typical)

**Why This Platform:**
1. ✅ **Superior debugging** - SSH, Python REPL, remote IDE (VS Code/CLion)
2. ✅ **Faster learning** - Python accessible from .NET (2-3 weeks vs. 3-6 months C/C++)
3. ✅ **Faster MVP** - 7-10 weeks to prototype vs. 12-16 weeks
4. ✅ **Rich ecosystem** - Python IoT libraries (gpiozero, CircuitPython, bluepy)
5. ✅ **Future flexibility** - Easy to add camera, ML, web dashboard post-MVP
6. ✅ **Lower abandonment risk** - Good tooling = sustained motivation

**Alternative Considered:** ESP32 (rejected for MVP due to debugging complexity, C/C++ learning curve)

**Future Path:** ESP32 nodes in Phase 2 for multi-zone hub-and-spoke architecture

---

## Sensor Selection: Final Decisions

### Recommended Sensor Kit (UPDATED 2025-10-01)

| **Sensor** | **Model** | **Interface** | **Cost** | **Measurements** |
|------------|-----------|---------------|----------|------------------|
| **Soil Moisture** | Adafruit STEMMA Soil (4026) | I2C | $7 | Moisture + Soil Temp |
| **Light** | Adafruit BH1750 (4681) | I2C | $6 | Lux (0-65,535) |
| **Air Temp/Humidity** | **Adafruit DHT20 (5183)** ⭐ | **I2C** | **$6** | Temp + Humidity |
| **Soil Temp (Optional)** | DS18B20 Waterproof | 1-Wire | $10 | Accurate Soil Temp |
| **TOTAL (Base)** | | | **$19** ✅ | **4 measurements** |
| **TOTAL (with DS18B20)** | | | **$29** | **5 measurements** |

**UPDATE:** DHT22 discontinued - replaced with DHT20 which is better (I2C interface, more accurate ±0.3°C, cheaper $6 vs $10 - saves $4!)

### Key Technical Decisions

**1. All I2C Digital Sensors (No ADC or Resistors Needed!)**

**Impact:** Eliminates MCP3008 ADC requirement AND pullup resistors
- ✅ **Saves $4** (no ADC chip)
- ✅ **Saves $3** (no resistors needed - DHT20 has built-in pullups)
- ✅ **Simpler wiring** - ALL 3 sensors share same I2C bus (SDA, SCL)
- ✅ **More accurate** - digital readings, no analog noise/drift
- ✅ **Easier coding** - all sensors use same I2C libraries
- ✅ **Total savings:** $7 vs original plan

**2. Capacitive Soil Moisture (vs. Resistive)**

**Impact:** Long-term reliability
- ✅ **2-5 year lifespan** vs. 3-6 months (resistive corrodes)
- ✅ **Stable readings** - no calibration drift from corrosion
- ⚠️ **$4-5 more expensive** - but worth it for outdoor deployment

**3. Pre-calibrated Sensors**

**Impact:** Minimal calibration burden
- ✅ **BH1750 light sensor** - pre-calibrated to lux values
- ✅ **DHT22 temp/humidity** - factory calibrated (±0.5°C, ±2-5% RH)
- ✅ **DS18B20 soil temp** - factory calibrated (±0.5°C)
- ⚠️ **Soil moisture** - requires one-time calibration (air + water reading)

### Sensor Wiring Summary (UPDATED 2025-10-01)

```
Raspberry Pi Zero 2 WH GPIO:
├─ Pin 1 (3.3V) ──→ All sensor VCC
├─ Pin 3 (SDA)  ──→ STEMMA Soil + BH1750 + DHT20 (I2C data) ⭐ ALL SENSORS!
├─ Pin 5 (SCL)  ──→ STEMMA Soil + BH1750 + DHT20 (I2C clock) ⭐
├─ Pin 6 (GND)  ──→ All sensor GND
└─ Pin 7 (GPIO4)──→ DS18B20 only (optional, 1-Wire)
```

**Total GPIO pins used:** 2 (SDA, SCL) - or 3 if using optional DS18B20
**Remaining GPIO:** 37-38 pins available for future expansion

**Major simplification:** All 3 core sensors on I2C bus - no resistors, no extra GPIO!

### Sensor Validation

**Coverage of MVP requirements:**
- ✅ **Soil moisture** - 0-100% (STEMMA Soil)
- ✅ **Light intensity** - 1-65,535 lux (BH1750)
- ✅ **Air temperature** - -40°C to 85°C (DHT20)
- ✅ **Air humidity** - 0-100% RH (DHT20)
- ✅ **Soil temperature** - -55°C to 125°C (DS18B20 or STEMMA Soil)

**Meets all MVP sensor requirements:** ✅ Yes

---

## Plant Database: Final Strategy

### Data Source: Manual Curation from University Extension Guides

**Primary sources:**
- UC Davis Vegetable Research & Information Center
- Cornell Cooperative Extension
- Oregon State University Extension
- North Carolina Extension Gardener
- Local state extension offices

**Why manual curation (not API):**
- ❌ **No viable API** - Existing plant APIs lack sensor-specific data
  - Trefle, OpenFarm, USDA Plants all provide qualitative data ("full sun") not quantitative (32,000 lux)
- ✅ **Local-first** - Aligns with project architecture (no cloud dependency)
- ✅ **Authoritative** - University extension = gold standard for plant care
- ✅ **Full control** - No rate limits, API deprecation, or licensing issues

### Data Format: YAML → JSON

**Storage:**
```
gardenapp/
├── data/
│   └── plants/
│       ├── vegetables/
│       │   ├── tomato-cherry.yaml
│       │   ├── pepper-bell.yaml
│       │   └── ...
│       └── herbs/
│           ├── basil.yaml
│           └── ...
└── mobile-app/
    └── assets/
        └── plants.json  # Compiled from YAML
```

**Schema (per plant):**
```yaml
common_name: "Cherry Tomato"
scientific_name: "Solanum lycopersicum var. cerasiforme"
optimal_ranges:
  soil_moisture: { min: 40, max: 60, unit: "percentage" }
  light: { hours_per_day: 6-8, min_lux: 32000, ideal_lux: 50000 }
  air_temperature: { min_c: 18, max_c: 29, ideal_c: 21-24 }
  soil_temperature: { germination_min_c: 15, growth_min_c: 18 }
sources:
  - "UC Davis Vegetable Research"
  - "Cornell Cooperative Extension"
```

### MVP Coverage

**Tier 1 (Launch):** 25 most common plants
- Vegetables (15): Tomato, Pepper, Lettuce, Cucumber, Zucchini, Carrot, Radish, Beans, Peas, Onion, Spinach, Kale, Broccoli, Cauliflower, Potato
- Herbs (8): Basil, Cilantro, Parsley, Mint, Oregano, Thyme, Rosemary, Dill
- Fruits (2): Strawberry, Blueberry

**Tier 2 (Post-MVP):** Expand to 50+ plants via community contributions

### Effort Estimate

**Per plant:** 60-90 minutes (research + YAML creation + validation)
**25 plants:** ~25-40 hours
**50 plants:** ~50-75 hours

**Timeline:** 2-3 months parallel with firmware/app development (2-3 hours/week)

**Feasibility:** ✅ Manageable for solo developer over MVP development period

---

## Recommended Tech Stack

### Hardware Stack

| **Component** | **Selection** | **Cost** |
|---------------|---------------|----------|
| **Microcontroller** | Raspberry Pi Zero 2 WH | $16-20 |
| **Storage** | MicroSD 16-32GB (high-endurance) | $8-12 |
| **Sensors** | STEMMA Soil + BH1750 + DHT22 (+ DS18B20 optional) | $23-33 |
| **Power** | 2× USB power banks (10,000-20,000mAh, swappable) | $30-50 |
| **Enclosure** | IP65 waterproof box | $12-20 |
| **Accessories** | MCP3008 ADC (not needed!), breadboard, wires | $10-15 |
| **TOTAL** | | **$99-150** |

**Production cost optimization (post-MVP):**
- Skip breadboard ($5 saved)
- Direct wire sensors ($5 saved)
- Generic power bank ($10 saved)
- **Optimized cost:** ~$87-120 per device

---

### Software Stack

| **Layer** | **Technology** | **Rationale** |
|-----------|----------------|---------------|
| **Firmware (Pi Zero)** | Python 3.9+ | Easy learning from .NET, rich IoT libraries |
| **GPIO Library** | gpiozero + Adafruit CircuitPython | Simple abstractions, well-documented |
| **Bluetooth** | bluepy or bleak | BLE support for mobile app sync |
| **Data Storage (Pi)** | SQLite or TinyDB (JSON) | Lightweight, local-first, no server |
| **Mobile App** | Android (native Kotlin or .NET MAUI - TBD) | Android device available for testing |
| **Plant Database** | YAML (source) → JSON (bundled) | Git-friendly, human-readable, offline-capable |
| **Development IDE** | VS Code Remote SSH or CLion Remote | Full debugging, SSH to Pi Zero |
| **Version Control** | Git + GitHub | Open-source, community contributions |

### Python Libraries (Raspberry Pi)

**GPIO & Sensors:**
```bash
pip3 install gpiozero                          # GPIO abstraction
pip3 install adafruit-circuitpython-seesaw     # STEMMA Soil sensor
pip3 install adafruit-circuitpython-bh1750     # BH1750 light sensor
pip3 install adafruit-circuitpython-dht        # DHT22 temp/humidity
pip3 install w1thermsensor                     # DS18B20 soil temp (1-Wire)
```

**Bluetooth:**
```bash
pip3 install bluepy   # BLE library (classic)
# or
pip3 install bleak    # Async BLE library (modern)
```

**Data Storage:**
```bash
# SQLite (built-in to Python)
# or
pip3 install tinydb   # Simple JSON database
```

**Utilities:**
```bash
pip3 install pyyaml   # YAML parsing (for plant data)
pip3 install schedule # Task scheduling (sensor sampling)
```

---

## Development Environment Setup

### Raspberry Pi Zero 2 WH Setup

**Initial setup:**
1. Flash Raspberry Pi OS Lite (64-bit) to MicroSD
2. Enable SSH (headless setup)
3. Enable I2C, 1-Wire interfaces via `raspi-config`
4. Install Python 3.9+ (pre-installed on Raspberry Pi OS)
5. Install pip packages (see above)

**Remote development:**
- **VS Code Remote SSH** (recommended for most)
- **CLion Remote Development** (if using PyCharm/CLion license)
- **Direct SSH** (vim/nano for quick edits)

### Mobile App Development (TBD in PRD/Architecture)

**Options to evaluate:**
1. **Android Native (Kotlin)** - Full Bluetooth control, native performance
2. **.NET MAUI** - Leverage .NET experience, cross-platform potential
3. **React Native / Flutter** - Cross-platform (iOS later)

**Decision deferred to:** Architecture phase (after PRD)

---

## MVP Feature Validation

### Core Features (From Project Brief)

| **Feature** | **Technical Feasibility** | **Status** |
|-------------|---------------------------|------------|
| **Soil moisture monitoring** | Pi Zero + STEMMA Soil sensor (I2C) | ✅ Feasible |
| **Light intensity monitoring** | BH1750 sensor (I2C, 0-65,535 lux) | ✅ Feasible |
| **Air temperature monitoring** | DHT22 sensor (GPIO, -40°C to 80°C) | ✅ Feasible |
| **Humidity monitoring** | DHT22 sensor (0-100% RH) | ✅ Feasible |
| **Soil temperature (optional)** | DS18B20 or STEMMA Soil | ✅ Feasible |
| **Data storage (local)** | SQLite or TinyDB on Pi Zero | ✅ Feasible |
| **Bluetooth sync to mobile** | bluepy/bleak + Android Bluetooth API | ✅ Feasible |
| **Plant database (50+ plants)** | YAML curation → JSON bundle | ✅ Feasible |
| **Basic recommendations** | Compare sensor readings vs. optimal ranges | ✅ Feasible |
| **Multi-device support** | Unique device IDs, mobile app manages multiple | ✅ Feasible |
| **Garden journal** | Mobile app local storage (SQLite) | ✅ Feasible |

**All MVP features validated:** ✅ Technically feasible with selected stack

---

## Constraint Validation

### Budget Constraint

**Target:** Under $300 per device (from project brief)
**Actual MVP cost:** $99-150 per device
**Margin:** $150-200 under budget

**Breakdown:**
- Pi Zero 2 WH: $18
- Sensors: $23-33
- Power (2× batteries): $30-50
- MicroSD: $10
- Enclosure: $12-20
- Accessories: $6-10

**Verdict:** ✅ Well under budget, room for upgrades or additional sensors

---

### Power Constraint (Remote Garden)

**Scenario:** Garden 150 feet from house (battery power required)

**Solution:** Swappable USB power banks
- 2× 10,000-20,000mAh USB power banks ($30-50)
- Swap weekly or bi-weekly (charge one while using one)
- No solar panel complexity for MVP

**Power consumption (Pi Zero 2 W):**
- Idle: 0.4W (100mA @ 5V)
- Active: 1.4W (280mA @ 5V)
- Average with sleep/sampling: ~0.6W (120mA @ 5V)

**Battery life calculation:**
- 10,000mAh power bank @ 5V = 50Wh
- Pi Zero @ 0.6W average = 50Wh / 0.6W = **83 hours (~3.5 days)**
- 20,000mAh power bank = **166 hours (~7 days)**

**Swap frequency:**
- 10,000mAh: Swap every 3 days
- 20,000mAh: Swap weekly

**Verdict:** ✅ Feasible with swappable battery strategy

---

### Timeline Constraint

**Goal:** Flexible timeline (personal learning project, no fixed deadline)
**Estimated MVP timeline:** 3-6 months part-time

**Breakdown:**

| **Phase** | **Tasks** | **Effort** | **Timeline** |
|-----------|-----------|------------|--------------|
| **Phase 1: Research** | Hardware, sensors, plant DB | ✅ Complete | Weeks 1-2 |
| **Phase 2: PRD** | Product requirements | 10-15 hours | Week 3 |
| **Phase 3: Architecture** | System design | 15-20 hours | Week 4-5 |
| **Phase 4: Firmware** | Python on Pi Zero | 60-80 hours | Weeks 6-13 (7-10 weeks) |
| **Phase 5: Mobile App** | Android app | 80-120 hours | Weeks 10-20 (10-15 weeks) |
| **Phase 6: Integration** | End-to-end testing | 20-30 hours | Weeks 18-22 |
| **Phase 7: Plant Data** | Curate 25 plants | 25-40 hours | Parallel (weeks 1-12) |

**Total effort:** ~210-305 hours
**Part-time (10-15 hrs/week):** 14-30 weeks (3.5-7.5 months)
**Realistic estimate:** **4-6 months** to working MVP

**Verdict:** ✅ Achievable within flexible timeline

---

### Learning Curve Constraint

**Developer background:** 8 years .NET/web development, new to IoT/hardware

**New skills required:**
1. **Python** (from C#) - ⭐⭐ Easy (2-3 weeks)
2. **Raspberry Pi GPIO** - ⭐⭐⭐ Moderate (2-3 weeks)
3. **I2C/1-Wire protocols** - ⭐⭐ Easy (1 week with libraries)
4. **Bluetooth Low Energy** - ⭐⭐⭐⭐ Moderate-Hard (3-4 weeks)
5. **Android development** - ⭐⭐⭐ Moderate (3-5 weeks if using .NET MAUI)
6. **Hardware assembly** - ⭐⭐ Easy (1 week prototyping)

**Learning timeline:** ~12-18 weeks to competency (parallel with development)

**Mitigation:**
- ✅ Python similar to C# (easy bridge)
- ✅ Adafruit libraries abstract complexity
- ✅ Claude Code for guidance
- ✅ Extensive tutorials for Pi Zero + Python IoT

**Verdict:** ✅ Manageable learning curve, Python choice minimizes frustration

---

## Risk Assessment

### Technical Risks

| **Risk** | **Likelihood** | **Impact** | **Mitigation** | **Status** |
|----------|----------------|------------|----------------|------------|
| **Sensor reliability (outdoor)** | Medium | High | Capacitive sensors (2-5 year lifespan), waterproof probes | ✅ Mitigated |
| **Battery life insufficient** | Low | Medium | 20,000mAh power bank = 7 days, swappable strategy | ✅ Mitigated |
| **Bluetooth range issues** | Medium | Medium | Test early, Pi Zero BT range ~30-100 feet (sufficient for garden) | ⚠️ Monitor |
| **Python learning curve** | Low | Low | Python easy from .NET, extensive resources | ✅ Mitigated |
| **Plant data curation effort** | Medium | Low | 25 plants = 25-40 hours (manageable over 3 months) | ✅ Mitigated |
| **Mobile app complexity** | Medium | Medium | Defer complex features to post-MVP, focus on data visualization + sync | ⚠️ Monitor |
| **SD card corruption (power loss)** | Low | Medium | Use high-endurance SD card, graceful shutdown scripts | ⚠️ Monitor |

**Overall risk level:** ✅ **LOW-MEDIUM** (manageable with selected stack)

---

### Non-Technical Risks

| **Risk** | **Likelihood** | **Impact** | **Mitigation** | **Status** |
|----------|----------------|------------|----------------|------------|
| **Scope creep (over-engineering)** | High | High | Strict adherence to MVP scope, defer all "nice-to-haves" | ⚠️ Active risk |
| **Motivation loss (project abandonment)** | Medium | Critical | Python + good debugging = less frustration, visible progress | ✅ Mitigated |
| **Time availability (life happens)** | Medium | Medium | Flexible timeline, no fixed deadline | ✅ Mitigated |
| **Hardware acquisition delays** | Low | Low | Pi Zero, sensors widely available (Amazon, Adafruit) | ✅ Low risk |

**Primary risk:** **Scope creep**
**Mitigation:** Strict MVP discipline, defer Phase 2 features until MVP is working

---

## MVP Success Criteria (Technical Validation)

From project brief, validating technical feasibility:

| **Success Criterion** | **Technical Approach** | **Feasibility** |
|-----------------------|------------------------|-----------------|
| **Device functions reliably (2+ weeks)** | Pi Zero + swappable battery (7-day swap) | ✅ Feasible |
| **Bluetooth sync works (95%+ success)** | bluepy/bleak + Android Bluetooth API | ✅ Feasible |
| **Data is useful (meaningful patterns)** | Sample every 15-60 min, store locally, visualize trends | ✅ Feasible |
| **Recommendations are helpful** | Compare actual vs. optimal ranges (plant database) | ✅ Feasible |
| **Plant database comprehensive (50+)** | Manual curation from university sources (25-50 plants MVP) | ✅ Feasible |
| **Setup is achievable** | Pi Zero + sensors via I2C/GPIO, documented setup | ✅ Feasible |
| **You actually use it (3×/week)** | Mobile app usability (deferred to UX/PM phase) | ⚠️ UX-dependent |
| **Foundation supports v2 features** | Pi Zero can add camera, additional sensors, web dashboard | ✅ Feasible |

**Technical success criteria:** ✅ **7/8 validated** (1 UX-dependent)

---

## Post-MVP Technical Roadmap

### Phase 2: Multi-Zone Architecture (Hybrid Hub-and-Spoke)

**Vision:**
- **Hub:** Raspberry Pi Zero 2 W (Python, coordinator, mobile sync)
- **Nodes:** ESP32 (C/C++, battery/solar, distributed sensors in garden beds)
- **Communication:** ESP-NOW or BLE mesh

**Benefits:**
- Leverage Pi Zero for complex logic (debugging ease)
- Leverage ESP32 for ultra-low power edge devices
- Existing ESP32 boards have purpose!
- Learn C/C++ after mastering IoT concepts with Python

**Feasibility:** ✅ Architecture supports future expansion

---

### Phase 3: Advanced Features

**Camera Module:**
- Raspberry Pi Camera Module 3 ($25)
- Photo-based pest/disease detection (image recognition)
- Requires ML libraries (TensorFlow Lite, feasible on Pi Zero)

**Advanced Sensors:**
- Soil NPK sensor (RS485, $50-100)
- pH sensor ($20-40)
- Rain gauge, wind speed, barometric pressure

**Community Features:**
- GitHub-based plant database contributions
- Anonymous local knowledge sharing (optional cloud integration)

**All feasible with selected platform:** ✅ Yes

---

## Recommended Next Steps

### Immediate Actions (Week 3)

1. ✅ **Phase 1 Research Complete** - All technical research validated
2. **Order Hardware:**
   - Raspberry Pi Zero 2 WH ($18)
   - MicroSD card 16-32GB high-endurance ($10)
   - 2× USB power banks 10,000-20,000mAh ($30-50)
   - Sensor kit: STEMMA Soil + BH1750 + DHT22 ($23)
   - Breadboard, jumper wires, resistors ($10)
   - **Total:** ~$91-111
3. **Begin PRD Development** (Phase 2.1):
   - Transform to PM agent
   - Create Product Requirements Document
   - Define user stories, acceptance criteria, MVP features
4. **Start plant data curation** (parallel):
   - Set up `data/plants/` folder structure
   - Create YAML schema
   - Begin Tier 1 plants (tomato, pepper, lettuce, basil)

### Phase 2: Product Definition (Weeks 3-4)

1. **PM creates PRD** informed by all research
2. **Optional: UX creates front-end spec** (if building rich mobile UI)
3. **Architect creates system architecture** (Python firmware + mobile app + Bluetooth sync + plant database)

### Phase 3: Development Kickoff (Week 5+)

1. **Firmware development** (Python on Pi Zero)
2. **Mobile app development** (Android)
3. **Plant database curation** (parallel, 2-3 hours/week)
4. **Integration testing** (end-to-end)

---

## Final Feasibility Statement

**OpenGardenLab MVP is TECHNICALLY FEASIBLE** with the selected technology stack:

✅ **Hardware:** Raspberry Pi Zero 2 WH + I2C digital sensors
✅ **Software:** Python (firmware) + Android (mobile app) + YAML plant database
✅ **Budget:** $99-150 per device (well under $300 target)
✅ **Timeline:** 4-6 months part-time (realistic for solo developer)
✅ **Learning Curve:** Manageable (Python from .NET, good debugging tools)
✅ **Local-First:** All components support offline-first architecture
✅ **Scalability:** Foundation supports Phase 2 multi-zone expansion

**Risks:** Low-Medium (manageable with selected stack and strict MVP discipline)

**Recommendation:** **PROCEED TO PRD DEVELOPMENT (Phase 2.1)**

---

## Appendices

### A. Bill of Materials (MVP Prototype)

| **Item** | **Quantity** | **Unit Cost** | **Total** | **Vendor** |
|----------|--------------|---------------|-----------|------------|
| Raspberry Pi Zero 2 WH | 1 | $18 | $18 | Amazon, Adafruit |
| MicroSD 16GB High-Endurance | 1 | $10 | $10 | SanDisk, Samsung |
| USB Power Bank 20,000mAh | 2 | $20 | $40 | Anker, RAVPower |
| Adafruit STEMMA Soil Sensor | 1 | $7 | $7 | Adafruit |
| Adafruit BH1750 Light Sensor | 1 | $6 | $6 | Adafruit |
| Adafruit DHT22 Temp/Humidity | 1 | $10 | $10 | Adafruit |
| DS18B20 Waterproof Probe (optional) | 1 | $10 | $10 | Amazon, Adafruit |
| STEMMA QT Cable (100mm, 2-pack) | 1 | $2 | $2 | Adafruit |
| 10kΩ resistor (pack) | 1 | $3 | $3 | Amazon |
| 4.7kΩ resistor (pack) | 1 | $3 | $3 | Amazon |
| Breadboard (400 tie-points) | 1 | $5 | $5 | Amazon |
| Jumper wires (M-F, 40-pack) | 1 | $5 | $5 | Amazon |
| IP65 Waterproof Enclosure | 1 | $15 | $15 | Amazon |
| Micro-USB cable | 1 | $3 | $3 | Amazon |
| **TOTAL** | | | **$137** | |

**Production optimization (post-MVP):** ~$87-120 (skip breadboard, cheaper enclosure)

---

### B. Software Dependencies

**Raspberry Pi (Python):**
```bash
# System packages
sudo apt update
sudo apt install python3-pip python3-gpiod libgpiod2

# GPIO & Sensors
pip3 install gpiozero
pip3 install adafruit-circuitpython-seesaw     # STEMMA Soil
pip3 install adafruit-circuitpython-bh1750     # BH1750 Light
pip3 install adafruit-circuitpython-dht        # DHT22
pip3 install w1thermsensor                     # DS18B20 (1-Wire)

# Bluetooth
pip3 install bluepy   # or bleak for async

# Data storage
pip3 install tinydb   # or use built-in sqlite3

# Utilities
pip3 install pyyaml
pip3 install schedule
```

**Mobile App (TBD - Android):**
- Kotlin: Android SDK, Bluetooth LE APIs
- .NET MAUI: .NET 8+, MAUI Bluetooth libraries
- React Native: React Native BLE Manager

---

### C. Reference Architecture Diagram (High-Level)

```
┌─────────────────────────────────────────────────────┐
│                Mobile App (Android)                 │
│  - Plant selection                                  │
│  - Data visualization (charts, trends)              │
│  - Recommendations engine                           │
│  - Garden journal                                   │
│  - Bluetooth sync controller                        │
└────────────────┬────────────────────────────────────┘
                 │
                 │ Bluetooth Low Energy
                 │ (Daily sync, 5-10 min connection)
                 │
┌────────────────▼────────────────────────────────────┐
│        Raspberry Pi Zero 2 W (Python)               │
│  - Sensor sampling (every 15-60 min)                │
│  - Data storage (SQLite/TinyDB)                     │
│  - Bluetooth server (advertise, accept connections) │
│  - Recommendation logic (optional, or in app)       │
└────┬────────┬────────┬────────┬─────────────────────┘
     │        │        │        │
     │ I2C    │ I2C    │ GPIO   │ 1-Wire
     │        │        │        │
     ▼        ▼        ▼        ▼
┌─────────┐ ┌─────┐ ┌─────┐ ┌──────────┐
│ STEMMA  │ │BH1750│ │DHT22│ │ DS18B20  │
│  Soil   │ │Light │ │Temp/│ │Soil Temp │
│Moisture │ │Sensor│ │Humid│ │  Probe   │
└─────────┘ └─────┘ └─────┘ └──────────┘
     │         │       │         │
     └────┬────┴───┬───┴────┬────┘
          │        │        │
          ▼        ▼        ▼
    ┌──────────────────────────┐
    │   Garden Soil / Plants   │
    └──────────────────────────┘

Data Flow:
1. Sensors → Pi Zero (every 15-60 min)
2. Pi Zero stores locally (SQLite)
3. Mobile app → Bluetooth sync → Pi Zero (daily)
4. Mobile app compares actual vs. optimal (plant database)
5. Mobile app shows recommendations

Plant Database:
- Bundled with mobile app (YAML → JSON)
- No API calls (local-first)
- Updated via app releases
```

---

### D. Development Timeline (Gantt Chart)

```
Week │ Phase 1   │ Phase 2      │ Phase 3-4        │ Phase 5-6          │
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
1-2  │ Research  │              │                  │                    │
     │ (Complete)│              │                  │                    │
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
3    │           │ PRD          │                  │                    │
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
4-5  │           │ Architecture │                  │                    │
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
6-13 │           │              │ Firmware (Python)│                    │
     │           │              │ 7-10 weeks       │                    │
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
10-20│           │              │                  │ Mobile App (10-15w)│
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤
18-22│           │              │                  │ Integration Testing│
─────┼───────────┼──────────────┼──────────────────┼────────────────────┤

Parallel Activities:
- Plant Data Curation: Weeks 1-12 (2-3 hours/week)
- Hardware Prototyping: Weeks 6-8 (test sensors)
- Documentation: Throughout
```

---

*Technical Feasibility Summary completed using the BMAD-METHOD™ framework*
*Architect: Winston | Date: 2025-10-01*
*Research Phase: COMPLETE ✅ | Recommendation: PROCEED TO PRD DEVELOPMENT*
