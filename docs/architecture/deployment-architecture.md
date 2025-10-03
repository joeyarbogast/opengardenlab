# Deployment Architecture

## Firmware Deployment (Raspberry Pi)

**Initial Setup (One-time per device):**

1. **Flash Raspberry Pi OS**
   - Download Raspberry Pi OS Lite (64-bit) from official site
   - Use Raspberry Pi Imager to flash to MicroSD card (16-32GB)
   - Enable SSH and configure WiFi during imaging (headless setup)
   - Insert SD card into Pi Zero 2 W, power on

2. **SSH Access and System Prep**
   ```bash
   ssh pi@raspberrypi.local
   # Default password: raspberry (change immediately)
   sudo passwd

   # Update system
   sudo apt update && sudo apt upgrade -y

   # Enable I2C and 1-Wire interfaces
   sudo raspi-config
   # Interface Options → I2C → Enable
   # Interface Options → 1-Wire → Enable
   # System Options → Hostname → opengardenlab-XXXX
   sudo reboot
   ```

3. **Install Python Dependencies**
   ```bash
   sudo apt install -y python3-pip i2c-tools
   pip3 install --upgrade pip

   # Install Adafruit libraries
   pip3 install adafruit-circuitpython-seesaw \
                adafruit-circuitpython-bh1750 \
                adafruit-circuitpython-ahtx0 \
                w1thermsensor \
                bleak \
                pyyaml
   ```

4. **Clone Repository and Configure**
   ```bash
   cd /home/pi
   git clone https://github.com/yourusername/opengardenlab.git
   cd opengardenlab/firmware

   # Copy config template and edit
   cp config.yaml.example config.yaml
   nano config.yaml
   # Set device_id to unique value (e.g., MAC address)
   ```

5. **Verify Sensor Connections**
   ```bash
   # Check I2C sensors detected
   i2cdetect -y 1
   # Should see addresses: 0x23 (BH1750), 0x36 (STEMMA), 0x38 (DHT20)

   # Test sensor reads
   python3 firmware/tests/test_sensors.py
   ```

6. **Create Systemd Service**
   ```bash
   sudo nano /etc/systemd/system/opengardenlab.service
   ```

   Service file contents:
   ```ini
   [Unit]
   Description=OpenGardenLab Sensor Sampling Service
   After=network.target

   [Service]
   Type=simple
   User=pi
   WorkingDirectory=/home/pi/opengardenlab/firmware
   ExecStart=/usr/bin/python3 /home/pi/opengardenlab/firmware/src/sensor_service.py
   Restart=on-failure
   RestartSec=10
   StandardOutput=append:/home/pi/opengardenlab/firmware/logs/service.log
   StandardError=append:/home/pi/opengardenlab/firmware/logs/service.log

   [Install]
   WantedBy=multi-user.target
   ```

7. **Enable and Start Service**
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable opengardenlab.service
   sudo systemctl start opengardenlab.service

   # Verify running
   sudo systemctl status opengardenlab.service

   # Monitor logs
   tail -f /home/pi/opengardenlab/firmware/logs/sensor_service.log
   ```

**Firmware Updates (Post-MVP OTA not implemented):**
- SSH into device
- `cd /home/pi/opengardenlab && git pull`
- `sudo systemctl restart opengardenlab.service`

**Production Optimizations:**
- Disable WiFi after initial setup: `sudo rfkill block wifi` (saves power, BLE still works)
- Reduce GPU memory allocation: Edit `/boot/config.txt`, set `gpu_mem=16`
- Disable HDMI output: Add to `/etc/rc.local`: `/usr/bin/tvservice -o`

---

## Mobile App Deployment (Android)

**Development Build:**

1. **Setup Development Environment**
   - Install Android Studio
   - Clone repository: `git clone https://github.com/yourusername/opengardenlab.git`
   - Open `mobile-app/` in Android Studio

2. **Build APK**
   ```bash
   cd mobile-app
   ./gradlew assembleDebug
   # Output: mobile-app/app/build/outputs/apk/debug/app-debug.apk
   ```

3. **Install on Device**
   ```bash
   # Via ADB
   adb install app-debug.apk

   # Or transfer APK to device, enable "Unknown Sources", tap to install
   ```

**Release Build (GitHub Releases):**

1. **Generate Signing Key** (one-time)
   ```bash
   keytool -genkey -v -keystore opengardenlab.keystore \
     -alias opengardenlab -keyalg RSA -keysize 2048 -validity 10000
   ```

2. **Build Signed APK**

   **Kotlin:**
   ```bash
   ./gradlew assembleRelease
   # Configure signing in app/build.gradle
   ```

3. **Create GitHub Release**
   ```bash
   # Tag version
   git tag -a v1.0.0 -m "MVP Release"
   git push origin v1.0.0

   # Upload APK to GitHub Releases page
   # Users download APK, enable "Unknown Sources", install
   ```

**CI/CD Pipeline (GitHub Actions):**

`.github/workflows/build-apk.yml`:
```yaml
name: Build Android APK
on:
  push:
    tags:
      - 'v*'
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          java-version: '17'
      - name: Build APK
        run: |
          cd mobile-app
          ./gradlew assembleRelease
      - name: Upload APK to Release
        uses: softprops/action-gh-release@v1
        with:
          files: mobile-app/app/build/outputs/apk/release/app-release.apk
```

---
