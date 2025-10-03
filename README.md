# OpenGardenLab - IoT Garden Monitoring System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**OpenGardenLab** is an open-source IoT garden monitoring system that helps home gardeners optimize plant care through continuous sensor monitoring and actionable recommendations.

## Overview

OpenGardenLab combines Raspberry Pi-based sensor monitoring with a local-first Android mobile app to provide:

- **Continuous monitoring** of soil moisture, light levels, temperature, and humidity
- **Bluetooth Low Energy sync** to Android mobile app (no WiFi or cloud required)
- **Plant database** with optimal growing ranges for 25+ vegetables, herbs, and fruits
- **Actionable recommendations** for watering, sunlight exposure, and environmental adjustments
- **Complete data ownership** - all data stays on your devices, no cloud dependency

This project is designed for home gardeners who want to learn IoT fundamentals while building practical garden monitoring hardware.

## Features (MVP)

- Real-time sensor readings from STEMMA Soil Sensor (moisture), VEML7700 (light), and BME280 (temp/humidity)
- 15-minute sampling interval with local SQLite storage
- Bluetooth sync to Android app for historical data and plant care insights
- Plant profiles with optimal ranges (e.g., "Tomato: 60-80% soil moisture, 6-8 hours full sun")
- Battery-powered operation with low-power sleep modes

## Tech Stack

- **Firmware:** Python 3.9+ on Raspberry Pi Zero 2 W
- **Mobile App:** Kotlin (Android 8.0+, API 26)
- **Database:** SQLite (local storage on both firmware and mobile)
- **Communication:** Bluetooth Low Energy (BLE)
- **Hardware:** Raspberry Pi Zero 2 W, STEMMA Soil Sensor, VEML7700 (light), BME280 (temp/humidity)

## Quick Start

### Hardware Requirements

- Raspberry Pi Zero 2 W
- STEMMA Soil Sensor (Adafruit #4026)
- VEML7700 Lux Sensor (Adafruit #4162)
- BME280 Temperature/Humidity Sensor (Adafruit #2652)
- MicroSD card (16GB+)
- Power supply or battery pack

### Firmware Setup

See [firmware/README.md](firmware/README.md) for detailed Raspberry Pi setup instructions.

### Mobile App Setup

See [mobile-app/README.md](mobile-app/README.md) for Android app build and installation instructions.

## Documentation

- [Product Requirements Document](docs/prd.md) - Full product specification and goals
- [System Architecture](docs/architecture.md) - Technical design and component details
- [Workflow Plan](docs/workflow-plan.md) - Development workflow and story breakdown

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

OpenGardenLab is an open-source learning project. Contributions, issues, and feature requests are welcome!

---

**Built with a local-first, privacy-focused philosophy. Your garden data belongs to you.**
