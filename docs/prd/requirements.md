# Requirements

## Functional

**FR1:** The system shall continuously monitor soil moisture levels (every 15-60 minutes, configurable) and store readings locally on the device with timestamps.

**FR2:** The system shall continuously monitor light intensity in lux (every 15-60 minutes) and calculate daily light hour totals to compare against plant requirements.

**FR3:** The system shall continuously monitor air temperature and humidity (every 15-60 minutes) to track ambient garden conditions.

**FR4:** The device shall store at least 30 days of sensor readings locally on the device (Raspberry Pi) to enable trend analysis even without frequent mobile app syncs.

**FR5:** The device shall sync collected sensor data to the mobile app via Bluetooth Low Energy when the user brings their mobile device within range (typically 30-100 feet).

**FR6:** The mobile app shall support multiple devices (multi-zone gardening), allowing users to label each device (e.g., "Tomato Bed", "Herb Garden") and switch between them to view data independently.

**FR7:** The mobile app shall include a comprehensive plant database with at least 50 common vegetables, fruits, and herbs, containing optimal ranges for soil moisture (%), light hours/day (lux), and temperature (°C).

**FR8:** The mobile app shall allow users to assign a plant type to each device/garden zone from the plant database.

**FR9:** The system shall generate basic recommendations by comparing actual sensor readings (averaged over configurable periods like 24 hours, 7 days) to optimal ranges for the assigned plant type and displaying actionable guidance.

**FR10:** The mobile app shall visualize sensor data using time-series charts with multiple views (daily, weekly, monthly) to help users identify trends and patterns.

**FR11:** The system shall include a garden journal feature where users can add timestamped notes, observations, and actions taken (e.g., "Watered 2 cups", "Added fertilizer"), attachable to specific devices/zones.

**FR12:** The device firmware shall be accessible via SSH for debugging, configuration updates, and manual data inspection by the developer.

**FR13:** The system shall allow one-time sensor calibration for soil moisture (air reading = 0%, water reading = 100%) with calibration values stored in device configuration.

**FR14:** The system shall operate entirely offline (no internet required after initial setup) - all sensor data storage, processing, and plant database queries shall work without external network connectivity.

## Non-Functional

**NFR1:** Device battery life shall be at least 7 days using swappable 20,000mAh USB power banks without solar charging (allowing weekly battery swap cycle).

**NFR2:** Bluetooth sync between device and mobile app shall complete within 5 minutes for 30 days of sensor data (15-minute intervals).

**NFR3:** Sensor readings shall be accurate enough for gardening decisions: soil moisture ±5%, light ±20%, temperature ±1°C (calibrated sensors).

**NFR4:** The device shall be deployable outdoors in a weatherproof enclosure (IP65 rated) and withstand outdoor conditions (rain, sun, temperature swings -10°C to 50°C).

**NFR5:** The total hardware cost per device shall not exceed $150 including Raspberry Pi, sensors, power, enclosure, and accessories.

**NFR6:** All software components (firmware, mobile app, plant database) shall be open-source under a permissive license (MIT or Apache 2.0 for code, CC0 or CC-BY for plant data).

**NFR7:** The system shall be buildable by a solo developer with .NET/web background but new to IoT hardware, following documented setup guides and leveraging community resources (Adafruit tutorials, Python libraries).

**NFR8:** The mobile app UI shall be intuitive enough for non-technical home gardeners to use without extensive documentation - core tasks (viewing data, assigning plants, reading recommendations) should be self-explanatory.

**NFR9:** The plant database shall cite authoritative sources (university extension guides) for all optimal range data to ensure recommendations are scientifically grounded.

**NFR10:** The firmware shall support future extensibility: adding new sensor types (NPK, pH, camera) should not require major architectural changes.

---
