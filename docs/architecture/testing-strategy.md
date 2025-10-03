# Testing Strategy

## Firmware Testing

**Unit Tests (pytest):**

```python
# firmware/tests/test_sensors.py
import pytest
from unittest.mock import MagicMock
from sensors.stemma_soil import STEMMASoilSensor

def test_calibrate_moisture():
    sensor = STEMMASoilSensor(MagicMock())

    # Test conversion: raw 500 → ~16.7% (air=200, water=2000)
    percentage = sensor.calibrate_moisture(500, 200, 2000)
    assert 16 <= percentage <= 17

    # Test clamping: raw value below air_value → 0%
    percentage = sensor.calibrate_moisture(100, 200, 2000)
    assert percentage == 0.0

    # Test clamping: raw value above water_value → 100%
    percentage = sensor.calibrate_moisture(2500, 200, 2000)
    assert percentage == 100.0

# firmware/tests/test_storage.py
def test_insert_and_query_readings():
    db = SensorDataStore(":memory:")  # In-memory DB for testing

    db.insert_reading(
        device_id="test-device",
        soil_moisture=45.2,
        soil_temp_stemma=22.1,
        soil_temp_ds18b20=21.8,
        light_lux=12000,
        air_temp=23.5,
        air_humidity=55.2
    )

    latest = db.get_latest_reading()
    assert latest['soil_moisture'] == 45.2
    assert latest['device_id'] == "test-device"
```

**Integration Tests:**
- Test full sensor read → storage → query flow with real hardware
- Manual testing in garden environment for 24-48 hours
- Monitor logs for errors/exceptions

**Coverage Target:** 70%+ for core logic (sensor drivers, storage, Bluetooth protocol handling)

---

## Mobile App Testing

**Unit Tests (JUnit/Espresso):**

```kotlin
// mobile-app/app/src/test/java/com/opengardenlab/RecommendationEngineTest.kt
@Test
fun testSoilMoistureTooLow() {
    val engine = RecommendationEngine()
    val plant = createMockPlant(soilMoistureMin = 40.0, soilMoistureMax = 60.0)

    val readings = List(10) { createMockReading(soilMoisture = 25.0) }

    val recommendations = engine.generateRecommendations(readings, plant)

    val moistureRec = recommendations.find { it.type == RecommendationType.SOIL_MOISTURE }
    assertNotNull(moistureRec)
    assertEquals(Severity.ALERT, moistureRec?.severity)
    assertTrue(moistureRec?.title?.contains("too dry") == true)
}

@Test
fun testPlantDatabaseLoader() {
    val service = PlantDatabaseService(context)
    val plants = service.getAllPlants()

    assertTrue(plants.size >= 25) // MVP requires at least 25 plants

    val tomato = service.getPlantById("tomato-cherry")
    assertNotNull(tomato)
    assertEquals("Cherry Tomato", tomato?.commonName)
}
```

**UI Tests (Espresso):**

```kotlin
@Test
fun testDashboardDisplaysReading() {
    // Mock repository to return test data
    val mockRepo = mockk<SensorReadingRepository>()
    coEvery { mockRepo.getLatestReading(any()) } returns SensorReading(
        deviceId = "test",
        timestamp = "2025-10-02T14:00:00Z",
        soilMoisture = 45.2,
        lightLux = 12000.0,
        // ...
    )

    launchActivity<DashboardActivity>()

    onView(withText("45%")).check(matches(isDisplayed())) // Soil moisture
    onView(withText("12000 lux")).check(matches(isDisplayed()))
}
```

**Manual Testing:**
- Test with real Raspberry Pi device (Bluetooth pairing, sync, calibration wizard)
- Multi-device workflow (pair 2+ devices, switch between them)
- Offline functionality (disable Bluetooth, verify cached data displays)
- Charts with 7 days of real sensor data

**Coverage Target:** 60%+ for business logic (recommendation engine, repositories)

---

## End-to-End Testing

**MVP Approach:** Manual E2E testing (automated E2E deferred to post-MVP)

**Test Scenarios:**

1. **New User Onboarding**
   - Fresh install of mobile app
   - Scan for devices → discover OpenGardenLab-XXXX
   - Pair device → verify device info shown
   - Assign plant → select "Cherry Tomato" from database
   - View dashboard → no data yet (never synced)
   - Tap "Sync" → 120 readings transferred
   - View charts → 7 days of data visualized
   - Check recommendations → "Soil is too dry" alert displayed

2. **Calibration Wizard**
   - Navigate to Settings → Calibration
   - Step 1: Remove sensor from soil → tap Next → air reading = 245
   - Step 2: Submerge in water → tap Next → water reading = 1820
   - Save calibration → verify success message
   - Check device config via SSH → calibration values updated in config.yaml

3. **Multi-Day Operation**
   - Deploy device in garden with power bank
   - Monitor for 7 days (no interaction)
   - SSH into device → verify systemd service still running
   - Check database: `sqlite3 data/sensor_data.db "SELECT COUNT(*) FROM sensor_readings"`
   - Expected: ~672 readings (7 days × 96 readings/day at 15-min intervals)
   - Sync to mobile app → verify all 672 readings transferred

4. **Garden Journal**
   - Add note: "Watered 2 cups"
   - Add note: "Noticed yellowing leaves"
   - View journal → entries sorted chronologically
   - Filter by device → only current device's notes shown

---
