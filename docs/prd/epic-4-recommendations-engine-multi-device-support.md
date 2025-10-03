# Epic 4: Recommendations Engine & Multi-Device Support

**Epic Goal:** Generate actionable plant care recommendations and add final MVP features (garden journal, device settings, calibration). By the end, OpenGardenLab delivers its core value: helping gardeners make data-driven decisions.

## Story 4.1: Recommendation Logic (Compare Actual vs Optimal Ranges)

**As a** mobile app,
**I want** to compare sensor readings to assigned plant's optimal ranges and generate insights,
**so that** users receive actionable guidance on plant care.

**Acceptance Criteria:**
1. Recommendation engine module created (`RecommendationEngine` class or similar)
2. Logic implemented for each sensor type:
   - **Soil Moisture:** Calculate average over last 7 days, compare to plant's optimal range (min/max %)
   - **Light:** Calculate average daily lux hours, compare to plant's required hours/day
   - **Temperature:** Check if current temp is within plant's optimal range
   - **Humidity:** Check if current humidity is within plant's optimal range
3. Generate recommendations:
   - If moisture < optimal min: "Soil is drier than optimal. Water more frequently."
   - If light < optimal hours: "Plant is receiving less sun than needed. Consider relocating."
   - If temp < optimal min: "Temperatures are below optimal. Provide frost protection or wait to plant."
4. Severity levels: Good (green), Caution (yellow), Alert (red)
5. Unit tests validate logic with mock readings and plant profiles

---

## Story 4.2: Recommendations Screen with Actionable Guidance

**As a** user,
**I want** a dedicated screen showing all current recommendations and trend-based insights,
**so that** I know exactly what actions to take to improve plant health.

**Acceptance Criteria:**
1. Recommendations screen created (accessible from Dashboard via "View Recommendations" button)
2. Screen displays list of recommendations:
   - Icon + severity color (green/yellow/red)
   - Recommendation text (e.g., "Soil moisture is 15% below optimal")
   - Suggested action (e.g., "Water 1-2 cups daily until moisture reaches 40-60%")
   - Timestamp of analysis ("Based on last 7 days of data")
3. Trend insights included:
   - "Moisture has dropped 20% over last 3 days" (if applicable)
   - "Light hours increasing (spring growth period)" (if applicable)
4. If no assigned plant, show: "Assign a plant to receive recommendations"
5. If no recommendations (all readings optimal), show: "Your plants are thriving! All conditions are optimal."
6. Test: Assign plant, sync data with suboptimal moisture, verify recommendation appears

---

## Story 4.3: Dashboard Integration of Recommendations

**As a** user,
**I want** the dashboard to show a summary of recommendations,
**so that** I see key issues immediately without navigating to separate screen.

**Acceptance Criteria:**
1. Dashboard updated with "Recommendations" section:
   - Show top 2 most critical recommendations (highest severity)
   - Compact card format (icon, title, brief description)
   - "View All" button → navigates to Recommendations screen
2. Color-coded status banner at top of dashboard:
   - Green: "All good! Plants are thriving"
   - Yellow: "2 cautions - review recommendations"
   - Red: "3 alerts - action needed"
3. If no plant assigned, banner shows: "Assign plant to receive insights"
4. Test: Dashboard shows correct recommendations based on synced data and assigned plant

---

## Story 4.4: Garden Journal (Note-Taking Feature)

**As a** user,
**I want** to add timestamped notes about garden observations and actions taken,
**so that** I can track what I've done and correlate it with sensor data.

**Acceptance Criteria:**
1. Garden Journal screen created (accessible from main navigation or dashboard)
2. Journal displays chronological list of entries:
   - User notes: "Watered 2 cups", "Added fertilizer", "Noticed yellowing leaves"
   - Auto-generated entries: "Device synced", "Plant assigned: Cherry Tomato"
   - Timestamp for each entry
3. "Add Note" button opens text input dialog:
   - User types note, taps "Save"
   - Entry added with current timestamp and device ID (attached to active device)
4. Filter options:
   - View all notes across all devices
   - Filter by specific device
   - Filter by date range (last 7 days, 30 days, etc.)
5. Local storage: Notes saved in SQLite table (`journal_entries`)
6. Test: Add 5 notes, switch devices, verify notes are correctly associated with devices

---

## Story 4.5: Device Settings - Sampling Interval Configuration

**As a** user,
**I want** to configure how often the device samples sensors,
**so that** I can balance battery life vs data granularity.

**Acceptance Criteria:**
1. Device Settings screen created (accessible from Dashboard "Settings" button or device list)
2. Setting: Sampling Interval
   - Dropdown or slider: 15 minutes, 30 minutes, 60 minutes
   - Current value displayed
   - "Save" button sends new interval to device via Bluetooth
3. Bluetooth protocol extended with "set_config" message:
   - Request: `{"type": "set_config", "sampling_interval_minutes": 30}`
   - Response: `{"type": "config_updated", "success": true}`
4. Firmware receives config update, writes to `firmware/config.yaml`, restarts sampling loop with new interval
5. Test: Change interval from 15min to 60min, verify firmware logs show new interval after sync

---

## Story 4.6: Device Settings - Soil Moisture Calibration

**As a** user,
**I want** to calibrate the soil moisture sensor for accurate readings,
**so that** moisture percentages reflect true soil conditions.

**Acceptance Criteria:**
1. Calibration wizard added to Device Settings:
   - Step 1: "Remove sensor from soil and let dry completely. Tap Next when ready."
   - Step 2: Device samples sensor, records "air reading" (0% moisture)
   - Step 3: "Submerge sensor tip in water (don't submerge electronics!). Tap Next when ready."
   - Step 4: Device samples sensor, records "water reading" (100% moisture)
   - Step 5: Calibration values sent to firmware, saved to config
2. Bluetooth protocol extended with calibration messages:
   - Request air reading: `{"type": "get_calibration_reading", "sensor": "soil_moisture"}`
   - Response: `{"type": "calibration_reading", "value": 200}`
   - Save calibration: `{"type": "set_calibration", "air_value": 200, "water_value": 1023}`
3. Firmware updates `config.yaml` with calibration values, applies to all future sensor readings
4. Test: Run calibration, verify subsequent moisture readings are in sensible 0-100% range

---

## Story 4.7: Device Settings - View Device Info

**As a** user,
**I want** to view device information (ID, firmware version, storage stats),
**so that** I can troubleshoot issues and know device status.

**Acceptance Criteria:**
1. Device Info section in Device Settings displays:
   - Device ID (Pi MAC address or unique identifier)
   - Device name/label (editable)
   - Firmware version (e.g., "1.0.0")
   - Storage: "1,234 readings stored (12.5 MB used, 28 days of data)"
   - Last synced timestamp
   - Battery/power status (if detectable - optional MVP feature)
2. "Edit Device Name" button allows renaming (e.g., "Tomato Bed" → "Front Yard Tomatoes")
3. Device info retrieved via Bluetooth "get_device_info" message (from Story 3.3)
4. Test: View device info, verify all fields display correctly

---

**Epic 4 Complete:** OpenGardenLab MVP is fully functional! Users can monitor multiple garden zones, receive data-driven plant care recommendations, journal observations, and configure device settings. All core value delivered.

---
