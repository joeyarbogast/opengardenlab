# Coding Standards

## Critical Rules (AI Agent Development)

**1. Python Type Hints**
```python
# ALWAYS use type hints for function parameters and return types
def read_moisture_raw(self) -> int:
def calibrate_moisture(self, raw_value: int, air_value: int, water_value: int) -> float:
```

**2. Consistent Error Handling**
```python
# Firmware: Log errors but don't crash the service
try:
    reading = sensor.read()
except Exception as e:
    logger.error(f"Sensor read failed: {e}")
    return None  # Continue loop
```

**3. JSON Protocol Consistency**
```python
# ALWAYS include "type" field in JSON messages
# ALWAYS use snake_case for JSON keys (matches Python/SQLite conventions)
response = {
    "type": "readings",
    "data": [...],
    "count": len(data)
}
```

**4. Bluetooth Disconnection**
```kotlin
// ALWAYS disconnect after Bluetooth operation completes
try {
    val readings = requestReadings(deviceId, since)
    return readings
} finally {
    gatt.disconnect()
    gatt.close()
}
```

**5. ISO 8601 Timestamps**
```python
# ALWAYS use UTC timestamps in ISO 8601 format
timestamp = datetime.utcnow().isoformat() + 'Z'
# Output: "2025-10-02T14:30:00Z"
```

**6. Database Migrations**
```python
# NEVER change SQLite schema without migration strategy
# For MVP: If schema changes, document manual migration steps
# Post-MVP: Implement Alembic (Python) or Room migrations (Android)
```

**7. Configuration Management**
```python
# ALWAYS update both YAML and SQLite when config changes via Bluetooth
def set_sampling_interval(self, interval: int):
    self.storage.update_config(sampling_interval_minutes=interval)
    self.config['sampling_interval_minutes'] = interval
    save_config(self.config)  # Write to YAML
```

---

## Naming Conventions

| **Element** | **Convention** | **Example** |
|-------------|----------------|-------------|
| Python Classes | PascalCase | `STEMMASoilSensor`, `SensorDataStore` |
| Python Functions | snake_case | `read_moisture_raw()`, `get_readings_since()` |
| Python Variables | snake_case | `soil_moisture`, `device_id` |
| Kotlin Classes | PascalCase | `DashboardViewModel`, `BluetoothClient` |
| Kotlin Functions | camelCase | `loadDashboard()`, `syncDevice()` |
| Kotlin Variables | camelCase | `soilMoisture`, `deviceId` |
| Database Tables | snake_case | `sensor_readings`, `device_config` |
| JSON Keys | snake_case | `"soil_moisture"`, `"device_id"` |
| BLE UUIDs | lowercase hex | `6e400001-b5a3-f393-e0a9-e50e24dcca9e` |

---
