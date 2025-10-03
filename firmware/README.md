# Firmware

Raspberry Pi firmware for OpenGardenLab sensor monitoring.

## Overview

This directory contains the Python firmware that runs on Raspberry Pi Zero 2 W to:
- Read sensors via I2C (soil moisture, light, temperature, humidity)
- Store readings in local SQLite database
- Provide Bluetooth Low Energy server for mobile app sync
- Manage power-efficient sampling intervals

## Setup

**Prerequisites:**
- Raspberry Pi Zero 2 W with Raspberry Pi OS Lite
- Python 3.9+
- I2C enabled (`sudo raspi-config` → Interface Options → I2C)

**Installation:**

```bash
cd firmware
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**Configuration:**

Edit `config.yaml` to set:
- Sampling interval (default: 15 minutes)
- Sensor calibration values
- Bluetooth device name

**Run:**

```bash
python src/main.py
```

**Autostart on Boot:**

```bash
sudo systemctl enable opengardenlab.service
sudo systemctl start opengardenlab.service
```

## Directory Structure

```
firmware/
├── src/               # Python source code
├── data/              # Runtime SQLite database (gitignored)
├── logs/              # Log files (gitignored)
├── tests/             # pytest unit tests
├── config.yaml        # Device configuration
├── requirements.txt   # Python dependencies
└── README.md          # This file
```

## Development

Implementation starts in **Story 1.2** and beyond.
