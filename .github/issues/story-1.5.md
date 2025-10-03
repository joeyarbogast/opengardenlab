## Story 1.5: 1-Wire Sensor Integration (DS18B20 Soil Temp Probe)

**Story File:** `docs/stories/1.5.1wire-sensor-ds18b20-integration.md`

**As a** developer,
**I want** the DS18B20 waterproof temperature probe reading soil temperature via 1-Wire,
**so that** I have a more accurate soil temperature sensor than the STEMMA Soil's built-in sensor.

### Acceptance Criteria
1. DS18B20 probe wired: Red→3.3V, Black→GND, Yellow→GPIO4 (Pin7), 4.7kΩ pullup resistor between Yellow and Red
2. 1-Wire kernel modules loaded (automatic after enabling 1-Wire in story 1.3)
3. `w1thermsensor` Python library installed (`pip3 install w1thermsensor`)
4. Python test script reads DS18B20 temperature successfully (prints temp in °C and °F)
5. DS18B20 reading matches room temperature ±1°C (validation test)

### Labels
- `epic-1`
- `story`
