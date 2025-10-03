## Story 1.6: Data Storage Service (SQLite Database Setup)

**Story File:** `docs/stories/1.6.data-storage-service-sqlite.md`

**As a** developer,
**I want** a SQLite database that stores sensor readings with timestamps,
**so that** the firmware can persist data locally for later sync to mobile app.

### Acceptance Criteria
1. SQLite database file created in `firmware/data/sensor_data.db`
2. Database schema created with table `sensor_readings`:
   - `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
   - `timestamp` (TEXT - ISO 8601 format)
   - `soil_moisture` (REAL - percentage 0-100)
   - `soil_temp_stemma` (REAL - °C from STEMMA sensor)
   - `soil_temp_ds18b20` (REAL - °C from DS18B20, nullable)
   - `light_lux` (REAL - lux 0-65535)
   - `air_temp` (REAL - °C from DHT20)
   - `air_humidity` (REAL - % RH from DHT20)
3. Python data access module (`firmware/storage.py`) with functions:
   - `insert_reading(timestamp, soil_moisture, soil_temp_stemma, soil_temp_ds18b20, light_lux, air_temp, air_humidity)`
   - `get_readings_since(timestamp)` - returns list of readings since given time
   - `get_latest_reading()` - returns most recent reading
4. Unit test script inserts 10 dummy readings, queries them back, verifies data integrity
5. Database file is persistent (survives Pi reboot)

### Labels
- `epic-1`
- `story`
