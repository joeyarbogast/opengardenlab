# Raspberry Pi Boot Configuration Templates

**Purpose:** Alternative to Raspberry Pi Imager GUI for reproducible headless setup

These templates allow you to configure SSH, WiFi, and user credentials by copying files to the SD card's boot partition **after** flashing Raspberry Pi OS.

---

## When to Use These Templates

**Use Raspberry Pi Imager (Recommended for Most Users):**
- Easiest method - GUI handles everything
- See `../HUMAN-SETUP-GUIDE.md` for step-by-step instructions

**Use These Templates (Advanced Users):**
- Automating multiple Pi setups
- Scripting deployment
- Prefer manual configuration control
- Raspberry Pi Imager not available

---

## Quick Start

### Step 1: Flash Base OS
1. Download Raspberry Pi OS Lite (64-bit) from https://www.raspberrypi.com/software/operating-systems/
2. Flash to MicroSD card using:
   - **GUI:** Raspberry Pi Imager (skip advanced options)
   - **CLI:** `dd` command (Linux/macOS) or Rufus/Win32DiskImager (Windows)

### Step 2: Customize Templates
1. Copy this `boot-templates/` folder to your computer
2. Edit files (see "Configuration Instructions" below):
   - `userconf.txt` - Set username and password
   - `wpa_supplicant.conf` - Set WiFi credentials
   - `ssh` - No changes needed (empty file)

### Step 3: Copy to Boot Partition
1. **After flashing**, SD card will have a partition named `boot` (FAT32)
2. Copy customized files to the root of the `boot` partition:
   ```
   /boot/
   ├── ssh                     (from template)
   ├── userconf.txt            (from template, customized)
   └── wpa_supplicant.conf     (from template, customized)
   ```
3. Safely eject SD card

### Step 4: Boot Raspberry Pi
1. Insert SD card into Raspberry Pi
2. Connect power
3. Wait 60-90 seconds for boot and WiFi connection
4. SSH into Pi: `ssh pi@opengardenlab.local` (or custom hostname)

---

## Configuration Instructions

### File: `ssh` (Enable SSH)
**What it does:** Enables SSH server on first boot

**Configuration:**
- **No changes needed** - this is an empty file
- Raspberry Pi OS checks for existence of `/boot/ssh` during first boot
- If present, SSH is enabled automatically

---

### File: `userconf.txt` (Set Username and Password)
**What it does:** Creates initial user account with encrypted password

**Configuration:**
1. Choose username (e.g., `pi`)
2. Generate encrypted password hash:
   ```bash
   echo 'mypassword' | openssl passwd -6 -stdin
   ```
   - Replace `mypassword` with your desired password
   - Output example: `$6$rounds=656000$abcdefg...` (copy this hash)

3. Edit `userconf.txt`:
   ```
   pi:$6$rounds=656000$abcdefg...
   ```
   - Format: `username:encrypted_password_hash`
   - **No spaces** around the colon

**Example:**
```bash
# Generate hash
echo 'opengardenlab123' | openssl passwd -6 -stdin
# Output: $6$rounds=656000$XYZ123...

# userconf.txt content:
pi:$6$rounds=656000$XYZ123...
```

---

### File: `wpa_supplicant.conf` (WiFi Configuration)
**What it does:** Configures WiFi credentials for network connection

**Configuration:**
1. Edit `wpa_supplicant.conf`
2. Update these fields:
   - `country=XX` - Your country code (e.g., `US`, `GB`, `DE`)
   - `ssid="YourNetworkName"` - WiFi network name (case-sensitive!)
   - `psk="YourNetworkPassword"` - WiFi password

**Example:**
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="MyHomeWiFi"
    psk="SuperSecretPassword123"
    key_mgmt=WPA-PSK
}
```

**Multiple Networks:**
You can add multiple `network` blocks for backup networks:
```
network={
    ssid="HomeWiFi"
    psk="password1"
    priority=10
}

network={
    ssid="MobileHotspot"
    psk="password2"
    priority=5
}
```
- Higher `priority` = preferred network

---

## Hostname Configuration (Optional)

**Default hostname:** `raspberrypi.local`

To set a custom hostname (e.g., `opengardenlab.local`):
1. After first boot, SSH into Pi
2. Edit `/etc/hostname`:
   ```bash
   sudo nano /etc/hostname
   ```
3. Replace `raspberrypi` with `opengardenlab`
4. Edit `/etc/hosts`:
   ```bash
   sudo nano /etc/hosts
   ```
5. Replace `raspberrypi` with `opengardenlab` in the `127.0.1.1` line
6. Reboot:
   ```bash
   sudo reboot
   ```
7. After reboot, SSH using new hostname: `ssh pi@opengardenlab.local`

---

## Verification

After booting with templates:

1. **WiFi connected:**
   ```bash
   ssh pi@raspberrypi.local
   iwconfig wlan0
   ```
   - Should show connected SSID

2. **SSH enabled:**
   - If you can SSH in, it's working!

3. **User account created:**
   ```bash
   whoami
   ```
   - Should show your username (e.g., `pi`)

---

## Troubleshooting

### SSH Not Working
- Verify `ssh` file is in `/boot/` (root of boot partition, not subdirectory)
- Check file has no extension (not `ssh.txt`)

### Wrong Password
- Verify password hash generated correctly with `openssl passwd -6 -stdin`
- Ensure `userconf.txt` has no spaces around colon: `username:hash`
- Try regenerating hash (some shells add newline characters)

### WiFi Not Connecting
- Verify SSID and password are correct (case-sensitive!)
- Check country code matches your location
- Ensure network is 2.4GHz (Pi Zero 2 W doesn't support 5GHz)
- Verify `wpa_supplicant.conf` has Unix line endings (LF, not CRLF)

### Hostname Not Resolving
- mDNS may be blocked on your network - use IP address instead
- Wait 2-3 minutes after boot for mDNS to propagate
- Try `ping raspberrypi.local` from multiple devices

---

## Security Notes

**⚠️ Do NOT commit `wpa_supplicant.conf` or `userconf.txt` with real credentials!**

- These templates have placeholders only
- Add your customized versions to `.gitignore`
- For shared setups, use environment variables or secrets management

---

## References

- [Raspberry Pi Headless Setup Documentation](https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-a-headless-raspberry-pi)
- [wpa_supplicant.conf Reference](https://www.raspberrypi.com/documentation/computers/configuration.html#configuring-networking)
- [OpenSSL Password Hashing](https://manpages.debian.org/bullseye/openssl/passwd.1ssl.en.html)
