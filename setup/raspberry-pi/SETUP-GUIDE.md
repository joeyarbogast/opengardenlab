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

## Next Steps

After completing Story 1.3, continue with:
- Story 1.4: Wire and test sensors (I2C and 1-Wire devices)
- Story 1.5: Install Python sensor libraries
- Story 1.6+: Clone firmware repository to Pi

**Happy gardening! 🌱**
