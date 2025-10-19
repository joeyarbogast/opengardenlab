#!/bin/bash
# verify-interfaces.sh
# Story 1.3: Verify I2C and 1-Wire interfaces are properly configured
# Run this after enable-interfaces.sh and reboot

echo "=================================================="
echo "I2C and 1-Wire Interface Verification"
echo "=================================================="
echo ""

PASS_COUNT=0
FAIL_COUNT=0

# Test 1: Check /dev/i2c-1 exists
echo "Test 1: I2C Device Node"
echo "------------------------"
if [ -e /dev/i2c-1 ]; then
    echo "✓ PASS: /dev/i2c-1 exists"
    ((PASS_COUNT++))
else
    echo "✗ FAIL: /dev/i2c-1 not found"
    echo "  Hint: Check if 'dtparam=i2c_arm=on' is in boot config and reboot"
    ((FAIL_COUNT++))
fi

echo ""

# Test 2: Check /sys/bus/w1/devices/ exists
echo "Test 2: 1-Wire Device Directory"
echo "--------------------------------"
if [ -d /sys/bus/w1/devices/ ]; then
    echo "✓ PASS: /sys/bus/w1/devices/ exists"
    DEVICE_COUNT=$(ls -1 /sys/bus/w1/devices/ | grep -v "w1_bus_master" | wc -l)
    echo "  Info: $DEVICE_COUNT 1-Wire device(s) detected (0 is OK if no sensors connected)"
    ((PASS_COUNT++))
else
    echo "✗ FAIL: /sys/bus/w1/devices/ not found"
    echo "  Hint: Check if 'dtoverlay=w1-gpio' is in boot config and reboot"
    ((FAIL_COUNT++))
fi

echo ""

# Test 3: Check i2cdetect installed
echo "Test 3: I2C Tools Installed"
echo "----------------------------"
if command -v i2cdetect &> /dev/null; then
    VERSION=$(i2cdetect -V 2>&1 | grep -oP '\d+\.\d+\.\d+' || echo 'unknown')
    echo "✓ PASS: i2cdetect installed (version: $VERSION)"
    ((PASS_COUNT++))
else
    echo "✗ FAIL: i2cdetect not installed"
    echo "  Hint: Run 'sudo apt install i2c-tools'"
    ((FAIL_COUNT++))
fi

echo ""

# Test 4: Run i2cdetect on bus 1
echo "Test 4: I2C Bus Scan"
echo "--------------------"
if command -v i2cdetect &> /dev/null; then
    if i2cdetect -y 1 &> /dev/null; then
        echo "✓ PASS: i2cdetect -y 1 ran without errors"
        echo ""
        echo "  I2C Bus 1 Scan Output:"
        echo "  ----------------------"
        i2cdetect -y 1 | sed 's/^/  /'
        echo ""
        echo "  Expected sensor addresses (when connected):"
        echo "    0x23 - BH1750 Light Sensor"
        echo "    0x36 - STEMMA Soil Sensor"
        echo "    0x38 - DHT20 Temp/Humidity Sensor"
        ((PASS_COUNT++))
    else
        echo "✗ FAIL: i2cdetect -y 1 returned an error"
        ((FAIL_COUNT++))
    fi
else
    echo "⊘ SKIP: i2cdetect not available"
fi

echo ""

# Test 5: Check I2C kernel modules loaded
echo "Test 5: I2C Kernel Modules"
echo "--------------------------"
I2C_MODULES=$(lsmod | grep i2c)
if [ -n "$I2C_MODULES" ]; then
    echo "✓ PASS: I2C kernel modules loaded"
    echo "$I2C_MODULES" | sed 's/^/  /'
    ((PASS_COUNT++))
else
    echo "✗ FAIL: No I2C kernel modules found"
    echo "  Hint: Check if I2C interface enabled in raspi-config"
    ((FAIL_COUNT++))
fi

echo ""

# Test 6: Check 1-Wire kernel modules loaded
echo "Test 6: 1-Wire Kernel Modules"
echo "------------------------------"
W1_MODULES=$(lsmod | grep w1)
if [ -n "$W1_MODULES" ]; then
    echo "✓ PASS: 1-Wire kernel modules loaded"
    echo "$W1_MODULES" | sed 's/^/  /'
    ((PASS_COUNT++))
else
    echo "✗ FAIL: No 1-Wire kernel modules found"
    echo "  Hint: Check if 1-Wire interface enabled in raspi-config"
    ((FAIL_COUNT++))
fi

echo ""

# Test 7: Check boot config entries
echo "Test 7: Boot Config Entries"
echo "----------------------------"

# Detect boot config location
BOOT_CONFIG=""
if [ -f /boot/firmware/config.txt ]; then
    BOOT_CONFIG="/boot/firmware/config.txt"
elif [ -f /boot/config.txt ]; then
    BOOT_CONFIG="/boot/config.txt"
fi

if [ -n "$BOOT_CONFIG" ]; then
    echo "Checking $BOOT_CONFIG:"
    echo ""

    # Check I2C entry
    if grep -q "^dtparam=i2c_arm=on" "$BOOT_CONFIG"; then
        echo "  ✓ I2C: dtparam=i2c_arm=on"
    else
        echo "  ✗ I2C: dtparam=i2c_arm=on NOT FOUND"
        ((FAIL_COUNT++))
    fi

    # Check 1-Wire entry
    if grep -q "^dtoverlay=w1-gpio" "$BOOT_CONFIG"; then
        echo "  ✓ 1-Wire: dtoverlay=w1-gpio"
    else
        echo "  ✗ 1-Wire: dtoverlay=w1-gpio NOT FOUND"
        ((FAIL_COUNT++))
    fi

    # Only increment pass count once if both entries found
    if grep -q "^dtparam=i2c_arm=on" "$BOOT_CONFIG" && grep -q "^dtoverlay=w1-gpio" "$BOOT_CONFIG"; then
        ((PASS_COUNT++))
    fi
else
    echo "✗ FAIL: Cannot find boot config file"
    ((FAIL_COUNT++))
fi

echo ""
echo "=================================================="
echo "Verification Summary"
echo "=================================================="
echo "Tests Passed: $PASS_COUNT"
echo "Tests Failed: $FAIL_COUNT"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo "✓ SUCCESS: All interface checks passed!"
    echo ""
    echo "Your Raspberry Pi is ready for sensor wiring (Story 1.4)"
    exit 0
else
    echo "✗ FAILURE: Some interface checks failed"
    echo ""
    echo "Troubleshooting steps:"
    echo "1. Run: ./enable-interfaces.sh"
    echo "2. Reboot: sudo reboot"
    echo "3. Run this script again"
    exit 1
fi
