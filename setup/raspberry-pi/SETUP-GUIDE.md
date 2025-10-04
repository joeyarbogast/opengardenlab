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

## Next Steps

After completing human setup, the AI agent will continue with:
- Story 1.3: Enable I2C and 1-Wire interfaces for sensor communication
- Story 1.4: Install Python sensor libraries
- Story 1.6+: Clone firmware repository to Pi

**Happy gardening! 🌱**
