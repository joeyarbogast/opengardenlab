# Mobile App

Android mobile application for OpenGardenLab garden monitoring.

## Overview

This directory contains the Kotlin Android app that provides:
- Bluetooth Low Energy client to sync with Raspberry Pi firmware
- Local SQLite database cache for sensor readings
- Time-series charts for moisture, light, temperature, and humidity
- Plant database with optimal growing ranges
- Plant care recommendations based on sensor data

## Setup

**Prerequisites:**
- Android Studio (latest stable version)
- Android SDK API 26+ (Android 8.0 Oreo or higher)
- Physical Android device for Bluetooth testing (emulator BLE support is limited)

**Build:**

1. Open this directory in Android Studio
2. Sync Gradle dependencies
3. Build APK: `Build → Build Bundle(s) / APK(s) → Build APK(s)`

**Install:**

```bash
# Via Android Studio
Click "Run" with device connected via USB

# Via command line
./gradlew installDebug
adb install app/build/outputs/apk/debug/app-debug.apk
```

## Directory Structure

```
mobile-app/
├── app/                      # Main application module
│   ├── src/main/
│   │   ├── java/            # Kotlin source code
│   │   ├── res/             # Android resources (layouts, drawables)
│   │   └── AndroidManifest.xml
│   └── build.gradle         # App-level Gradle config
├── build.gradle             # Project-level Gradle config
├── settings.gradle          # Gradle settings
└── README.md                # This file
```

## Development

Implementation starts in **Story 2.1** and beyond.

## Testing

- Unit tests: `./gradlew test`
- Instrumented tests: `./gradlew connectedAndroidTest`
