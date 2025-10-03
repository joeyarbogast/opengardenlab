## Story 1.4: Sensor Library Installation and I2C Sensor Test

**Story File:** `docs/stories/1.4.sensor-library-i2c-test.md`

**As a** developer,
**I want** Adafruit CircuitPython libraries installed and I2C sensors (STEMMA Soil, BH1750, DHT20) reading successfully,
**so that** I can validate hardware wiring and sensor functionality before building the full sampling service.

### Acceptance Criteria
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

### Labels
- `epic-1`
- `story`
