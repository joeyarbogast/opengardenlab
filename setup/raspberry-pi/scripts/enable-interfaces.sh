#!/bin/bash
# enable-interfaces.sh
# Story 1.3: Enable I2C and 1-Wire interfaces on Raspberry Pi
# This script is idempotent - safe to run multiple times

set -e

echo "=================================================="
echo "I2C and 1-Wire Interface Setup for Raspberry Pi"
echo "=================================================="
echo ""

# Detect boot config location (varies by Raspberry Pi OS version)
BOOT_CONFIG=""
if [ -f /boot/firmware/config.txt ]; then
    BOOT_CONFIG="/boot/firmware/config.txt"
    echo "✓ Detected boot config: /boot/firmware/config.txt (newer Pi OS)"
elif [ -f /boot/config.txt ]; then
    BOOT_CONFIG="/boot/config.txt"
    echo "✓ Detected boot config: /boot/config.txt (older Pi OS)"
else
    echo "✗ ERROR: Cannot find boot config file!"
    echo "  Checked: /boot/config.txt and /boot/firmware/config.txt"
    exit 1
fi

echo ""
echo "Step 1: Check I2C Interface"
echo "----------------------------"

# Check if I2C already enabled
if grep -q "^dtparam=i2c_arm=on" "$BOOT_CONFIG"; then
    echo "✓ I2C already enabled in $BOOT_CONFIG"
else
    echo "→ Enabling I2C interface..."
    echo "dtparam=i2c_arm=on" | sudo tee -a "$BOOT_CONFIG" > /dev/null
    echo "✓ Added 'dtparam=i2c_arm=on' to $BOOT_CONFIG"
    REBOOT_REQUIRED=true
fi

echo ""
echo "Step 2: Check 1-Wire Interface"
echo "-------------------------------"

# Check if 1-Wire already enabled
if grep -q "^dtoverlay=w1-gpio" "$BOOT_CONFIG"; then
    echo "✓ 1-Wire already enabled in $BOOT_CONFIG"
else
    echo "→ Enabling 1-Wire interface..."
    echo "dtoverlay=w1-gpio" | sudo tee -a "$BOOT_CONFIG" > /dev/null
    echo "✓ Added 'dtoverlay=w1-gpio' to $BOOT_CONFIG"
    REBOOT_REQUIRED=true
fi

echo ""
echo "Step 3: Install I2C Tools"
echo "-------------------------"

# Check if i2c-tools installed
if command -v i2cdetect &> /dev/null; then
    echo "✓ i2c-tools already installed (version: $(i2cdetect -V 2>&1 | grep -oP '\d+\.\d+\.\d+' || echo 'unknown'))"
else
    echo "→ Installing i2c-tools package..."
    sudo apt update -qq
    sudo apt install i2c-tools -y
    echo "✓ i2c-tools installed successfully"
fi

echo ""
echo "=================================================="
echo "Setup Complete!"
echo "=================================================="
echo ""

if [ "$REBOOT_REQUIRED" = true ]; then
    echo "⚠️  REBOOT REQUIRED to activate interface changes"
    echo ""
    echo "Run: sudo reboot"
    echo ""
    echo "After reboot, verify setup with:"
    echo "  ./verify-interfaces.sh"
else
    echo "✓ No reboot required (interfaces already enabled)"
    echo ""
    echo "Verify setup with:"
    echo "  ./verify-interfaces.sh"
fi

echo ""
