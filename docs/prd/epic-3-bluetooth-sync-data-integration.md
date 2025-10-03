# Epic 3: Bluetooth Sync & Data Integration

**Epic Goal:** Implement Bluetooth Low Energy communication between Raspberry Pi firmware and mobile app. By the end, you'll have end-to-end data flow: sensors → firmware → Bluetooth → mobile app → charts.

## Story 3.1: Bluetooth BLE Server on Raspberry Pi (Advertising and Connection)

**As a** Raspberry Pi device,
**I want** to advertise as a BLE peripheral and accept connections from the mobile app,
**so that** the app can discover and pair with the device.

**Acceptance Criteria:**
1. Python BLE library installed (`bluepy` or `bleak` - recommend `bleak` for async)
2. BLE server script `firmware/bluetooth_server.py` created with:
   - Device advertises as "OpenGardenLab-XXXX" (XXXX = last 4 digits of Pi MAC address)
   - Service UUID defined (custom UUID for OpenGardenLab)
   - Characteristic UUID for data sync (read/write)
3. BLE server runs continuously (alongside sensor sampling service, or integrated)
4. BLE server accepts connection from any BLE central device
5. Test: Use generic BLE scanner app (nRF Connect, LightBlue) to discover "OpenGardenLab" device, connect successfully

---

## Story 3.2: Bluetooth BLE Client in Mobile App (Device Discovery and Pairing)

**As a** mobile app user,
**I want** to scan for nearby OpenGardenLab devices and pair via Bluetooth,
**so that** I can connect my app to my garden monitoring device.

**Acceptance Criteria:**
1. Android Bluetooth permissions requested (BLUETOOTH, BLUETOOTH_ADMIN, ACCESS_FINE_LOCATION for BLE scan)
2. Device Discovery screen created with:
   - "Scan for Devices" button
   - List of discovered BLE devices (name "OpenGardenLab-XXXX", signal strength)
   - Tap device to pair/connect
3. BLE scan functionality implemented:
   - Scans for devices advertising OpenGardenLab service UUID
   - Displays device name and signal strength (RSSI)
4. Connect to device:
   - Taps device in list → initiates BLE connection
   - Connection success/failure feedback (toast or dialog)
5. Paired device saved to app local storage (device ID, name, last connected timestamp)
6. Test: Scan discovers Pi device, connect succeeds, device added to app's paired device list

---

## Story 3.3: Data Sync Protocol (JSON Message Format)

**As a** system architect,
**I want** a defined JSON message format for syncing sensor data over Bluetooth,
**so that** firmware and mobile app can communicate reliably.

**Acceptance Criteria:**
1. Protocol documented in `docs/bluetooth-protocol.md` with message schemas:
   - **Request from app:** `{"type": "get_readings", "since": "2025-10-01T12:00:00Z"}` (ISO timestamp)
   - **Response from device:** `{"type": "readings", "data": [{"timestamp": "...", "soil_moisture": 45.2, ...}, ...]}`
   - **Device info request:** `{"type": "get_device_info"}`
   - **Device info response:** `{"type": "device_info", "device_id": "...", "firmware_version": "1.0"}`
2. Firmware Bluetooth server implements message handling:
   - Receives JSON string via BLE write characteristic
   - Parses JSON, executes query (e.g., `get_readings_since(timestamp)`)
   - Responds with JSON string via BLE read characteristic or notification
3. Mobile app implements message sending:
   - Constructs JSON request
   - Sends via BLE write, waits for response
   - Parses JSON response
4. Protocol handles large payloads (30 days of readings = ~3,000 data points):
   - Option 1: Chunked transfer (send in batches)
   - Option 2: Compression (gzip JSON before BLE transfer)
5. Test: Send "get_device_info" from app, receive valid device info JSON from Pi

---

## Story 3.4: Firmware - Bluetooth Data Sync Handler

**As a** Raspberry Pi firmware,
**I want** to respond to mobile app sync requests by querying SQLite and sending sensor data,
**so that** the app receives up-to-date sensor readings.

**Acceptance Criteria:**
1. Bluetooth sync handler integrated into `firmware/bluetooth_server.py` or separate module
2. Handler processes "get_readings" requests:
   - Parses `since` timestamp from request JSON
   - Calls `storage.get_readings_since(since_timestamp)`
   - Converts query results to JSON response (list of readings)
   - Sends JSON back to mobile app via BLE
3. Handler processes "get_device_info" requests:
   - Returns device_id (Pi MAC or unique ID), firmware version, storage stats
4. Large payloads handled (3,000+ readings):
   - If JSON response > 512 bytes, split into chunks (BLE MTU limitation)
   - OR compress with gzip, send compressed bytes
5. Test: Request readings since "1 week ago", verify all readings transferred successfully

---

## Story 3.5: Mobile App - Bluetooth Data Sync and Local Storage

**As a** mobile app,
**I want** to request sensor data from the Pi device via Bluetooth and store it locally,
**so that** users can view data offline even when not connected to the device.

**Acceptance Criteria:**
1. Mobile app local SQLite database created (Room for Kotlin, SQLite.NET for .NET MAUI)
2. Database schema mirrors firmware schema (sensor_readings table)
3. Sync function implemented:
   - Determine last synced timestamp from local DB
   - Send BLE request: `get_readings since last_synced_timestamp`
   - Receive JSON response, parse readings
   - Insert new readings into local DB
   - Update "last synced" timestamp
4. Sync initiated from Dashboard screen "Sync" button:
   - Button shows loading spinner during sync
   - Success/failure feedback (toast: "Synced 120 new readings" or "Sync failed")
5. Sync tested: 7 days of data (700+ readings) syncs in < 5 minutes, all data stored locally

---

## Story 3.6: Dashboard and Charts Display Real Sensor Data

**As a** user,
**I want** the dashboard and charts to display real sensor data from my device,
**so that** I can see actual garden conditions instead of mock data.

**Acceptance Criteria:**
1. Dashboard screen updated to query local DB for latest sensor reading (replaces mock data)
2. Sensor readings displayed: soil moisture, light lux, air temp, air humidity (from synced data)
3. If no data available (new device, never synced), show "Sync device to view data" message
4. Historical charts screen updated to query local DB for time-series data:
   - Query last 24 hours / 7 days / 30 days of readings
   - Plot real data on line charts
5. Chart X-axis shows actual timestamps, Y-axis shows actual sensor values
6. Test: Sync device, dashboard shows real readings, charts show real trends

---

## Story 3.7: Multi-Device Support (Device List and Switcher)

**As a** user with multiple garden zones,
**I want** to pair multiple devices and switch between them in the app,
**so that** I can monitor different garden beds independently.

**Acceptance Criteria:**
1. Device List screen created:
   - List of paired devices (name, last synced, connection status)
   - Tap device to switch to it (makes it "active device")
   - "Add Device" button → opens Device Discovery screen (from Story 3.2)
2. Active device concept:
   - App tracks currently selected device (stored in local settings)
   - Dashboard shows data for active device only
   - Charts show data for active device only
3. Device switcher on Dashboard (dropdown or swipe gesture):
   - Quick switch between paired devices without navigating to Device List
4. Each device has independent data in local DB (device_id column added to readings table)
5. Test: Pair 2 devices, sync both, switch between them, verify dashboard shows correct device's data

---

**Epic 3 Complete:** You now have full Bluetooth sync working. Sensor data flows from Pi to mobile app, displays on dashboard and charts. Multi-device support allows monitoring multiple garden zones.

---
