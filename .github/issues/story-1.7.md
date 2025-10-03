## Story 1.7: Sensor Sampling Service (Core Firmware Loop)

**Story File:** `docs/stories/1.7.sensor-sampling-service-core-firmware.md`

**As a** developer,
**I want** a Python service that reads all sensors every N minutes and stores readings in SQLite,
**so that** the device continuously monitors garden conditions without manual intervention.

### Acceptance Criteria
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

### Labels
- `epic-1`
- `story`
