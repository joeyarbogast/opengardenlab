# Next Steps

## Immediate Actions (Start MVP Development)

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

## Post-MVP: Future Phases

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
