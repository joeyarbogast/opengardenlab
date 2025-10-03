# Epic 2: Mobile App Foundation & Plant Database

**Epic Goal:** Create Android mobile app structure, load plant database, and implement core UI screens (dashboard, plant selection). By the end, you'll have an app that can browse plants and display mock sensor data, ready for Bluetooth integration.

## Story 2.1: Android Project Setup and Navigation Framework

**As a** developer,
**I want** an Android app project with navigation between screens,
**so that** I have the foundation for building OpenGardenLab mobile app UI.

**Acceptance Criteria:**
1. Android project created in `mobile-app/` folder using Android Studio or VS Code + .NET MAUI
2. Framework decision finalized (Kotlin native or .NET MAUI) based on developer preference
3. Minimum Android SDK version set (Android 8.0 / API 26 for BLE support)
4. Navigation framework configured (Jetpack Navigation for Kotlin, or .NET MAUI Shell)
5. App builds successfully and runs on Android device/emulator
6. Basic navigation between 3 placeholder screens: Dashboard, Plant Selection, Settings

---

## Story 2.2: Plant Database YAML Structure and Compilation Script

**As a** developer,
**I want** YAML plant data files compiled to JSON for app bundling,
**so that** the mobile app can load plant care information offline without external APIs.

**Acceptance Criteria:**
1. YAML schema defined for plant profiles in `plant-database/schema/plant-schema.yaml`
2. Folder structure created: `plant-database/vegetables/`, `plant-database/herbs/`, `plant-database/fruits/`
3. 5 sample plant YAML files created (e.g., tomato-cherry.yaml, basil.yaml) with full optimal ranges
4. Python compilation script `scripts/compile-plants.py` that:
   - Reads all YAML files from plant-database/
   - Validates against schema
   - Outputs single `plants.json` file
5. JSON file copied to mobile app assets folder (`mobile-app/assets/plants.json`)
6. Compilation script tested: YAML → JSON conversion works, validates schema

---

## Story 2.3: Plant Database Curation (Initial 25 Plants - Tier 1)

**As a** product manager,
**I want** 25 common garden plants documented with optimal care ranges,
**so that** the mobile app has sufficient plant data for MVP testing and early users.

**Acceptance Criteria:**
1. 25 plant YAML files created (from MVP plant list: tomato, pepper, lettuce, cucumber, basil, etc.)
2. Each plant profile includes:
   - Common name, scientific name, category (vegetable/herb/fruit)
   - Optimal soil moisture range (min/max %)
   - Light requirements (hours/day, lux range)
   - Air temperature range (min/max °C)
   - Sources cited (university extension guides)
3. All profiles validated against YAML schema (no errors in compilation script)
4. plants.json compiled and bundled with mobile app
5. Spot-check: 5 random plants manually verified against source documents for accuracy

---

## Story 2.4: Plant Database Loader and Query Service (Mobile App)

**As a** mobile app,
**I want** to load plants.json on app startup and provide plant query functions,
**so that** UI screens can browse, search, and display plant information.

**Acceptance Criteria:**
1. Plant database loader service created (`PlantDatabaseService` or similar)
2. plants.json loaded from app assets on startup, parsed into memory (list of plant objects)
3. Query functions implemented:
   - `getAllPlants()` - returns all plants
   - `searchPlants(query: String)` - case-insensitive search by common name
   - `getPlantsByCategory(category: String)` - filter by "vegetable", "herb", "fruit"
   - `getPlantById(id: String)` - get specific plant by ID/name
4. Unit tests verify query functions work correctly (search "tomato" returns 3+ varieties, etc.)
5. Plant data persists across app restarts (no re-parsing JSON every launch - cache in memory)

---

## Story 2.5: Device Dashboard Screen with Mock Data

**As a** user,
**I want** a dashboard screen that shows current sensor readings and plant info,
**so that** I can see garden status at a glance (using mock data initially, real data in Epic 3).

**Acceptance Criteria:**
1. Dashboard screen UI created with layout:
   - Device name/label at top ("Tomato Bed")
   - Current sensor readings: Soil Moisture (%), Light (lux), Temperature (°C), Humidity (%)
   - Each reading has icon (droplet, sun, thermometer, water drop) and color-coded status (green/yellow/red)
   - Assigned plant info card (plant photo placeholder, name, optimal ranges)
   - Last sync timestamp ("Synced 5 minutes ago")
   - Sync button (does nothing yet, placeholder for Epic 3)
2. Mock data hardcoded for testing:
   - Soil moisture: 45%, Light: 12,000 lux, Temp: 22°C, Humidity: 55%
   - Assigned plant: "Cherry Tomato"
3. Dashboard displays mock data correctly, layout looks clean and readable
4. Navigation: Dashboard is default/home screen when app launches

---

## Story 2.6: Plant Selection Screen with Browse and Search

**As a** user,
**I want** to browse and search the plant database to assign a plant type to my device,
**so that** the app can compare sensor readings to the correct optimal ranges.

**Acceptance Criteria:**
1. Plant Selection screen UI created with:
   - Search bar at top (filter plants by name)
   - Category tabs or filter: All, Vegetables, Fruits, Herbs
   - Scrollable list of plants (name, thumbnail image placeholder, brief description)
   - Tap plant to view details modal/screen
2. Plant detail view shows:
   - Plant name, photo placeholder, scientific name
   - Optimal ranges (moisture %, light hours/lux, temperature °C)
   - "Assign to Device" button
3. Search functionality works: typing "tom" filters to tomato varieties
4. Category filter works: tapping "Herbs" shows only herb plants
5. Assign plant button (mock functionality - just closes modal for now, real assignment in Epic 4)

---

## Story 2.7: Chart Library Integration with Mock Sensor Data

**As a** user,
**I want** to see time-series charts of sensor readings over time,
**so that** I can identify trends and patterns in garden conditions (mock data initially).

**Acceptance Criteria:**
1. Chart library integrated (MPAndroidChart for Kotlin, or Microcharts/.NET MAUI Charts)
2. Historical Data screen created (accessible from dashboard via "View Charts" button)
3. 4 line charts displayed:
   - Soil Moisture (%) over time
   - Light (lux) over time
   - Air Temperature (°C) over time
   - Air Humidity (%) over time
4. Mock time-series data generated (last 7 days, readings every hour)
5. X-axis: Time (hourly ticks), Y-axis: Sensor value
6. Charts scroll/zoom (if library supports)
7. View toggle: 24 hours, 7 days (mock toggle buttons, both show same mock 7-day data for now)

---

## Story 2.8: Mobile App Distribution Strategy and Build Configuration

**As a** developer,
**I want** a documented strategy for building, signing, and distributing the Android app to users,
**so that** I can deploy the MVP to real users and iterate based on feedback.

**Acceptance Criteria:**
1. App signing configuration documented in `docs/app-distribution-guide.md`:
   - Generate release keystore for signing APKs (`keytool -genkey`)
   - Configure Gradle signing config for release builds (Kotlin) or .NET MAUI signing
   - Document keystore storage location and backup procedure (DO NOT commit keystore to Git)
2. Build process documented:
   - Debug build: `./gradlew assembleDebug` (Kotlin) or `dotnet build` (.NET MAUI)
   - Release build: `./gradlew assembleRelease` (Kotlin) or `dotnet publish` (.NET MAUI)
   - Output APK location: `mobile-app/app/build/outputs/apk/release/` (Kotlin)
3. MVP distribution strategy documented:
   - **Phase 1 (MVP):** Direct APK distribution via GitHub Releases
   - Users download APK, enable "Install from Unknown Sources", install manually
   - Release versioning: v1.0.0 (follows semantic versioning)
4. Post-MVP distribution options documented:
   - **Phase 4:** Google Play Store submission (requires Google Play Developer account - $25 one-time fee)
   - **Phase 4 (optional):** F-Droid open-source app store (free, aligns with open-source goals)
5. Version tracking added to mobile app:
   - App version displayed in Settings screen ("Version 1.0.0")
   - Version code incremented with each release
6. First release build created successfully:
   - Build and sign release APK
   - Install on test device, verify app runs correctly

**Notes:**
- MVP uses manual APK distribution (simple, no app store review delays)
- Google Play Store deferred to Phase 4 (after MVP validation with real users)
- F-Droid submission requires reproducible builds (research needed, defer to Phase 4)

---

**Epic 2 Complete:** You now have a mobile app that can browse 25 plants, display a dashboard with mock sensor data, and visualize charts. Ready for Bluetooth integration to replace mock data with real sensor readings.

---
