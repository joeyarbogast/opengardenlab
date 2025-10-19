# Raspberry Pi Setup Guide

**Story:** 1.2 - Raspberry Pi OS Setup and SSH Access
**Audience:** Developers setting up OpenGardenLab firmware development environment
**Hardware:** Raspberry Pi Zero 2 W

---

## Prerequisites

**Required Hardware:**
- Raspberry Pi Zero 2 W
- 16-32GB MicroSD card (Class 10 or UHS-I for best performance)
- MicroSD card reader (USB adapter or built-in)
- Power supply: 5V 2.5A micro USB power supply

**Required Software:**
- Computer with WiFi/Ethernet connection to same network as Pi
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/) (free download)

**Network Requirements:**
- 2.4GHz WiFi network (Pi Zero 2 W only supports 2.4GHz)
- WiFi SSID and password

---

## Step 1: Flash Raspberry Pi OS to MicroSD Card

### 1.1 Download Raspberry Pi Imager
1. Visit https://www.raspberrypi.com/software/
2. Download Raspberry Pi Imager for your operating system (Windows/macOS/Linux)
3. Install and launch Raspberry Pi Imager

### 1.2 Insert MicroSD Card
1. Insert 16-32GB MicroSD card into your computer's card reader
2. **⚠️ WARNING:** All data on this card will be erased!

### 1.3 Select Operating System
1. Click **"Choose OS"** button
2. Navigate to: **Raspberry Pi OS (other)** → **Raspberry Pi OS Lite (64-bit)**
   - **Why Lite:** No desktop environment = less resource usage, faster boot
   - **Why 64-bit:** Better performance on Pi Zero 2 W's 64-bit CPU

### 1.4 Select Storage Device
1. Click **"Choose Storage"** button
2. Select your MicroSD card from the list
3. **⚠️ Double-check:** Ensure you selected the correct device!

### 1.5 Configure Advanced Options (Headless Setup)
1. Click the **⚙️ gear icon** (bottom right) to open advanced options
2. Configure the following settings:

**Hostname:**
- Set hostname: `opengardenlab` (or keep default `raspberrypi`)
- Note: You'll use this for SSH access (`ssh pi@opengardenlab.local`)

**Enable SSH:**
- ✅ Check **"Enable SSH"**
- Select **"Use password authentication"** (easier for development)

**Set Username and Password:**
- Username: `pi` (recommended, matches documentation)
- Password: Choose a **secure password** (you'll need this for SSH login)
- **⚠️ Write down your password!** You'll need it in Step 2.

**Configure Wireless LAN:**
- ✅ Check **"Configure wireless LAN"**
- SSID: Enter your WiFi network name (case-sensitive!)
- Password: Enter your WiFi password
- Wireless LAN country: Select your country (e.g., `US`)

**Locale Settings:**
- Timezone: Select your timezone (e.g., `America/New_York`)
- Keyboard layout: Select your keyboard layout (e.g., `us`)

### 1.6 Write OS to MicroSD Card
1. Click **"Save"** to save advanced options
2. Click **"Write"** button to begin flashing
3. Confirm data erasure warning (click **"Yes"**)
4. Wait for write and verification to complete (5-10 minutes)
5. When complete, you'll see **"Write Successful"** message
6. Click **"Continue"**
7. **Safely eject** MicroSD card from your computer

---

## Step 2: Boot Raspberry Pi and Test SSH Access

### 2.1 Insert MicroSD Card and Power On
1. Insert MicroSD card into Raspberry Pi (card slot on underside)
2. Connect micro USB power supply to the **PWR IN** port (not the USB port!)
3. **Wait 60-90 seconds** for initial boot and WiFi connection
   - **LED indicators:**
     - Power LED (red): Should be solid ON
     - Activity LED (green): Blinks during boot/disk activity

### 2.2 Find Pi on Your Network
**Option A: Use Hostname (Recommended)**
```bash
ping opengardenlab.local
```
- If ping succeeds, your Pi is online! Proceed to Step 2.3.
- If ping fails, try Option B.

**Option B: Find IP Address via Router**
1. Log into your WiFi router's admin panel
2. Look for connected devices list
3. Find device named `opengardenlab` or `raspberrypi`
4. Note the IP address (e.g., `192.168.1.150`)

### 2.3 SSH into Raspberry Pi
**Using Hostname:**
```bash
ssh pi@opengardenlab.local
```

**Using IP Address (if hostname fails):**
```bash
ssh pi@192.168.1.150
```

**First Connection:**
1. You'll see a warning about authenticity of host (SSH fingerprint)
2. Type `yes` and press Enter to accept and save fingerprint
3. Enter your password (set in Step 1.5)
4. **Success!** You should see a command prompt like:
   ```
   pi@opengardenlab:~ $
   ```

### 2.4 Verify SSH Connection
Run the following command to verify you're logged in:
```bash
hostname
```
- Expected output: `opengardenlab` (or `raspberrypi` if you kept default)

---

## Step 3: Notify AI Agent

✅ **You've completed the human tasks!**

Tell the AI agent:
```
I've completed the hardware setup. Pi is online and I'm connected via SSH.
Hostname: opengardenlab.local (or provide IP if using static IP)
Proceed with AI tasks.
```

The AI agent will now:
1. Create boot configuration templates for the repository
2. Configure static IP or verify hostname resolution
3. Verify Python 3.9+ installation
4. Update system and install essential tools (git, pip3)

---

## Troubleshooting

### SSH Connection Refused
**Problem:** `ssh: connect to host opengardenlab.local port 22: Connection refused`

**Solutions:**
1. Wait longer (initial boot can take 2-3 minutes)
2. Check power LED is solid red (Pi is powered)
3. Verify WiFi credentials were entered correctly in Step 1.5
4. Try finding IP via router (Step 2.2 Option B) and SSH using IP

### Hostname Resolution Fails
**Problem:** `ping: cannot resolve opengardenlab.local: Unknown host`

**Solutions:**
1. Try using IP address instead (Step 2.2 Option B)
2. Check your computer and Pi are on the same network
3. Some networks block mDNS (hostname resolution) - use static IP instead

### Wrong Password
**Problem:** `Permission denied (publickey,password)`

**Solutions:**
1. Verify you're using the password set in Step 1.5
2. Username must be `pi` (or whatever you set in Step 1.5)
3. If forgotten, re-flash MicroSD card and start over

### WiFi Not Connecting
**Problem:** Pi not appearing on network

**Solutions:**
1. Verify WiFi SSID and password are correct (case-sensitive!)
2. Ensure network is 2.4GHz (Pi Zero 2 W doesn't support 5GHz)
3. Check WiFi country code matches your location
4. Try moving Pi closer to WiFi router

---

---

## Story 1.3: Enable I2C and 1-Wire Interfaces

**Goal:** Configure Raspberry Pi to communicate with digital sensors (I2C) and DS18B20 temperature probes (1-Wire).

### Prerequisites
- Completed Story 1.2 (SSH access to Raspberry Pi)
- Repository cloned to your development machine

---

### Option A: Automated Setup (Recommended)

**Step 1: Deploy Setup Scripts to Raspberry Pi**

From your development machine (in the project root directory):

```bash
# Create setup directory on Pi
ssh pi@opengardenlab.local "mkdir -p ~/setup"

# Copy setup scripts to Pi
scp -r setup/raspberry-pi/* pi@opengardenlab.local:~/setup/

# Verify files transferred
ssh pi@opengardenlab.local "ls -la ~/setup/scripts/"
```

**Step 2: Run Interface Setup Script**

SSH into your Raspberry Pi:
```bash
ssh pi@opengardenlab.local
```

Run the automated setup script:
```bash
cd ~/setup/scripts
./enable-interfaces.sh
```

This script will:
- ✅ Detect your boot config location automatically
- ✅ Enable I2C interface (idempotent - safe to run multiple times)
- ✅ Enable 1-Wire interface (idempotent)
- ✅ Install i2c-tools package
- ✅ Inform you if reboot is required

**Step 3: Reboot (if required)**

If the script indicates a reboot is needed:
```bash
sudo reboot
```

Wait 60 seconds, then reconnect via SSH.

**Step 4: Verify Setup**

Run the verification script:
```bash
cd ~/setup/scripts
./verify-interfaces.sh
```

**Expected output:**
```
==================================================
I2C and 1-Wire Interface Verification
==================================================

Test 1: I2C Device Node
✓ PASS: /dev/i2c-1 exists

Test 2: 1-Wire Device Directory
✓ PASS: /sys/bus/w1/devices/ exists

Test 3: I2C Tools Installed
✓ PASS: i2cdetect installed (version: X.X.X)

Test 4: I2C Bus Scan
✓ PASS: i2cdetect -y 1 ran without errors

Test 5: I2C Kernel Modules
✓ PASS: I2C kernel modules loaded

Test 6: 1-Wire Kernel Modules
✓ PASS: 1-Wire kernel modules loaded

Test 7: Boot Config Entries
✓ I2C: dtparam=i2c_arm=on
✓ 1-Wire: dtoverlay=w1-gpio

==================================================
✓ SUCCESS: All interface checks passed!

Your Raspberry Pi is ready for sensor wiring (Story 1.4)
```

---

### Option B: Manual Setup

If you prefer manual configuration or the automated script fails:

**Step 1: Enable Interfaces via raspi-config**

SSH into your Raspberry Pi and run:
```bash
sudo raspi-config
```

**Enable I2C:**
1. Navigate to: **3 Interface Options** → **I5 I2C**
2. Select **"Yes"** to enable I2C interface
3. Press **"OK"** to confirm

**Enable 1-Wire:**
1. Navigate to: **3 Interface Options** → **I7 1-Wire**
2. Select **"Yes"** to enable 1-Wire interface
3. Press **"OK"** to confirm

**Exit and Reboot:**
1. Select **"Finish"**
2. Select **"Yes"** when prompted to reboot
3. Wait 60 seconds, then reconnect via SSH

**Step 2: Install i2c-tools**

```bash
sudo apt update
sudo apt install i2c-tools -y
```

Verify installation:
```bash
i2cdetect -V
```

**Step 3: Verify I2C Interface**

Check I2C device exists:
```bash
ls /dev/i2c*
```
- Expected: `/dev/i2c-1`

Scan I2C bus:
```bash
i2cdetect -y 1
```
- Expected: Grid showing "--" in all cells (no sensors connected yet)

**Step 4: Verify 1-Wire Interface**

Check 1-Wire device directory:
```bash
ls /sys/bus/w1/devices/
```
- Expected: `w1_bus_master1` (directory may be empty if no sensors connected)

Verify kernel modules loaded:
```bash
lsmod | grep i2c
lsmod | grep w1
```
- Expected: `i2c_dev`, `i2c_bcm2835`, `w1_gpio`, `w1_therm` modules listed

**Step 5: Verify Boot Config**

Check boot configuration file (location varies by OS version):

```bash
# Try newer OS location first
cat /boot/firmware/config.txt | grep -E "i2c_arm|w1-gpio"

# If not found, try older OS location
cat /boot/config.txt | grep -E "i2c_arm|w1-gpio"
```

**Expected output:**
```
dtparam=i2c_arm=on
dtoverlay=w1-gpio
```

---

### Reference: Boot Config Snippet

For manual configuration or troubleshooting, see the template file:
- **File:** `setup/raspberry-pi/config/config.txt.snippet`
- **Contents:** Documented boot config entries with comments explaining each setting

---

### Expected I2C Sensor Addresses (Story 1.4+)

When sensors are connected in Story 1.4, `i2cdetect -y 1` will show:
- **0x23** - BH1750 Light Sensor
- **0x36** - STEMMA Soil Sensor
- **0x38** - DHT20 Temperature/Humidity Sensor

---

### Troubleshooting

**Problem:** `/dev/i2c-1` does not exist after reboot

**Solutions:**
1. Verify boot config entry: `cat /boot/firmware/config.txt | grep i2c_arm`
2. If missing, manually add: `echo "dtparam=i2c_arm=on" | sudo tee -a /boot/firmware/config.txt`
3. Reboot: `sudo reboot`

---

**Problem:** `i2cdetect: command not found`

**Solution:**
```bash
sudo apt update
sudo apt install i2c-tools -y
```

---

**Problem:** `/sys/bus/w1/devices/` does not exist after reboot

**Solutions:**
1. Verify boot config entry: `cat /boot/firmware/config.txt | grep w1-gpio`
2. If missing, manually add: `echo "dtoverlay=w1-gpio" | sudo tee -a /boot/firmware/config.txt`
3. Reboot: `sudo reboot`
4. Verify kernel modules: `lsmod | grep w1`

---

## Story 1.4: Install Sensor Libraries and Test I2C Sensors

**Goal:** Install Adafruit CircuitPython libraries and validate I2C sensor communication.

### Prerequisites
- Completed Story 1.3 (I2C and 1-Wire interfaces enabled)
- SSH access to Raspberry Pi

---

### Step 1: Install Sensor Libraries (Automated)

**Deploy and Run Installation Script:**

From your development machine (in the project root directory):

```bash
# If not already done, copy setup scripts to Pi (includes new sensor library script)
scp -r setup/raspberry-pi/* pi@opengardenlab.local:~/setup/
```

SSH into your Raspberry Pi:
```bash
ssh pi@opengardenlab.local
```

Run the sensor library installation script:
```bash
cd ~/setup/scripts
./install-sensor-libraries.sh
```

This script will:
- ✅ Verify Python 3.9+ installation
- ✅ Upgrade pip3 to latest version
- ✅ Install Adafruit Blinka (CircuitPython compatibility layer)
- ✅ Install sensor libraries:
  - `adafruit-circuitpython-seesaw` (STEMMA Soil Sensor)
  - `adafruit-circuitpython-bh1750` (BH1750 Light Sensor)
  - `adafruit-circuitpython-ahtx0` (DHT20/AHT20 Temp/Humidity)
- ✅ Display installed library versions for verification

**Expected output snippet:**
```
✓ Python 3 installed: 3.13.x
✓ pip3 upgraded successfully
✓ adafruit-blinka installed successfully
✓ STEMMA Soil Sensor library installed
✓ BH1750 Light Sensor library installed
✓ DHT20 Temp/Humidity Sensor library installed

Installed Adafruit libraries:
adafruit-circuitpython-ahtx0             1.0.27
adafruit-circuitpython-bh1750            1.1.16
adafruit-circuitpython-seesaw            1.16.7
...
```

---

### Step 2: Wire I2C Sensors (HUMAN REQUIRED)

**⚠️ IMPORTANT: Power off Raspberry Pi before wiring sensors!**

```bash
sudo shutdown -h now
```

Wait for activity LED to stop blinking (Pi is fully powered off).

**Wiring Instructions:**

All three I2C sensors share the same 4 GPIO pins:

| **Sensor Pin** | **GPIO Pin** | **Pin Number** | **Purpose** |
|----------------|--------------|----------------|-------------|
| VCC (Red)      | 3.3V         | Pin 1          | Power (3.3V) |
| GND (Black)    | Ground       | Pin 6          | Ground |
| SDA (White)    | GPIO2/SDA    | Pin 3          | I2C Data Line (shared) |
| SCL (Yellow)   | GPIO3/SCL    | Pin 5          | I2C Clock Line (shared) |

**Sensors to wire:**
1. **STEMMA Soil Sensor** (I2C Address: 0x36)
   - Use STEMMA QT cable (plug-and-play) OR jumper wires to breadboard
2. **BH1750 Light Sensor** (I2C Address: 0x23)
   - Connect VCC, GND, SDA, SCL to same GPIO pins as STEMMA
3. **DHT20 Temp/Humidity Sensor** (I2C Address: 0x38)
   - Connect VCC, GND, SDA, SCL to same GPIO pins

**After wiring:**
- Double-check all connections
- Power on Raspberry Pi
- Wait 60 seconds for boot
- Reconnect via SSH

---

### Step 3: Verify I2C Sensor Detection

SSH into Raspberry Pi and run:
```bash
i2cdetect -y 1
```

**Expected output:**
```
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- 23 -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- 36 -- 38 -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
```

**Verify sensor addresses:**
- ✅ `23` = BH1750 Light Sensor
- ✅ `36` = STEMMA Soil Sensor
- ✅ `38` = DHT20 Temp/Humidity Sensor

**If any sensor is missing:**
1. Check wiring connections (VCC, GND, SDA, SCL)
2. Verify sensors are powered (3.3V to Pin 1)
3. Ensure I2C interface enabled (run `./verify-interfaces.sh`)
4. Reboot and re-scan: `sudo reboot`

---

### Step 4: Test Sensor Readings

**Create test script directory:**
```bash
mkdir -p ~/opengardenlab/firmware/tests
```

**Create test script:**
```bash
nano ~/opengardenlab/firmware/tests/test_i2c_sensors.py
```

**Copy this code:**
```python
#!/usr/bin/env python3
import time
import board
from adafruit_seesaw.seesaw import Seesaw
from adafruit_bh1750 import BH1750
from adafruit_ahtx0 import AHTx0

# Initialize I2C bus
i2c = board.I2C()

# Initialize sensors
print("Initializing sensors...")
stemma = Seesaw(i2c, addr=0x36)
bh1750 = BH1750(i2c)
dht20 = AHTx0(i2c)

print("Reading sensors...\n")

# Read STEMMA Soil Sensor
moisture_raw = stemma.moisture_read()
soil_temp_c = stemma.get_temp()
print(f"STEMMA Soil Sensor:")
print(f"  Moisture (raw): {moisture_raw}")
print(f"  Soil Temp: {soil_temp_c:.1f}°C\n")

# Read BH1750 Light Sensor
lux = bh1750.lux
print(f"BH1750 Light Sensor:")
print(f"  Light: {lux:.1f} lux\n")

# Read DHT20 Air Temp/Humidity
air_temp_c = dht20.temperature
humidity = dht20.relative_humidity
print(f"DHT20 Air Temp/Humidity:")
print(f"  Air Temp: {air_temp_c:.1f}°C")
print(f"  Humidity: {humidity:.1f}%\n")

print("Test complete!")
```

Save and exit: `Ctrl+X`, `Y`, `Enter`

**Make script executable:**
```bash
chmod +x ~/opengardenlab/firmware/tests/test_i2c_sensors.py
```

**Run test script:**
```bash
python3 ~/opengardenlab/firmware/tests/test_i2c_sensors.py
```

**Expected output:**
```
Initializing sensors...
Reading sensors...

STEMMA Soil Sensor:
  Moisture (raw): 512
  Soil Temp: 22.3°C

BH1750 Light Sensor:
  Light: 348.2 lux

DHT20 Air Temp/Humidity:
  Air Temp: 23.1°C
  Humidity: 45.6%

Test complete!
```

**Verify readings are sensible:**
- ✅ Moisture raw: 200-2000 (varies by air vs water, uncalibrated)
- ✅ Soil temp: 15-30°C (indoor room temperature)
- ✅ Lux: 100-500 (indoor), 10,000-65,000 (direct sunlight)
- ✅ Air temp: 15-30°C (room temperature)
- ✅ Humidity: 20-80% (typical indoor range)

---

### Troubleshooting

**Problem:** `ModuleNotFoundError: No module named 'adafruit_seesaw'`

**Solution:**
```bash
pip3 list | grep adafruit
# If library missing, re-run installation script
cd ~/setup/scripts
./install-sensor-libraries.sh
```

---

**Problem:** `ValueError: No I2C device at address: 0x36` (or 0x23, 0x38)

**Solutions:**
1. Run `i2cdetect -y 1` to verify sensor appears on bus
2. Check sensor wiring (VCC, GND, SDA, SCL)
3. Verify sensor is powered (measure 3.3V on VCC pin with multimeter)
4. Try different I2C address if sensor has configurable address jumper

---

**Problem:** Sensor readings are nonsensical (e.g., -40°C, 0 lux indoors)

**Solutions:**
1. Re-run test script (some sensors need initialization time)
2. Power cycle Raspberry Pi: `sudo reboot`
3. Check sensor datasheet for initialization delays
4. Replace sensor if hardware fault suspected

---

## Next Steps

After completing Story 1.4, continue with:
- Story 1.5: Add DS18B20 1-Wire temperature probe
- Story 1.6+: Build firmware sampling service

**Happy gardening! 🌱**
