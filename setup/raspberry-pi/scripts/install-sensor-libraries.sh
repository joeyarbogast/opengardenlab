#!/bin/bash
# install-sensor-libraries.sh
# Story 1.4: Install Adafruit CircuitPython sensor libraries
# This script is idempotent - safe to run multiple times

set -e

echo "========================================================"
echo "Adafruit CircuitPython Sensor Libraries Installation"
echo "========================================================"
echo ""

# Check Python 3 version
echo "Step 1: Verify Python 3 Installation"
echo "-------------------------------------"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | grep -oP '\d+\.\d+\.\d+' || echo 'unknown')
    echo "✓ Python 3 installed: $PYTHON_VERSION"
else
    echo "✗ ERROR: Python 3 not found!"
    exit 1
fi

echo ""
echo "Step 2: Upgrade pip3"
echo "--------------------"
echo "→ Upgrading pip3..."
pip3 install --upgrade pip --break-system-packages
echo "✓ pip3 upgraded successfully"

echo ""
echo "Step 3: Install Adafruit Blinka (CircuitPython Compatibility Layer)"
echo "--------------------------------------------------------------------"
if pip3 list 2>/dev/null | grep -q "adafruit-blinka"; then
    CURRENT_VERSION=$(pip3 list 2>/dev/null | grep "adafruit-blinka" | awk '{print $2}')
    echo "✓ adafruit-blinka already installed (version: $CURRENT_VERSION)"
    echo "→ Upgrading to latest version..."
    pip3 install --upgrade adafruit-blinka --break-system-packages
else
    echo "→ Installing adafruit-blinka..."
    pip3 install adafruit-blinka --break-system-packages
    echo "✓ adafruit-blinka installed successfully"
fi

echo ""
echo "Step 4: Install Sensor Libraries"
echo "---------------------------------"

# STEMMA Soil Sensor (I2C capacitive moisture + soil temp)
echo "→ Installing adafruit-circuitpython-seesaw (STEMMA Soil Sensor)..."
pip3 install adafruit-circuitpython-seesaw --break-system-packages
echo "✓ STEMMA Soil Sensor library installed"

# BH1750 Light Sensor (I2C lux sensor)
echo "→ Installing adafruit-circuitpython-bh1750 (BH1750 Light Sensor)..."
pip3 install adafruit-circuitpython-bh1750 --break-system-packages
echo "✓ BH1750 Light Sensor library installed"

# DHT20/AHT20 Temp/Humidity Sensor (I2C)
echo "→ Installing adafruit-circuitpython-ahtx0 (DHT20 Temp/Humidity Sensor)..."
pip3 install adafruit-circuitpython-ahtx0 --break-system-packages
echo "✓ DHT20 Temp/Humidity Sensor library installed"

echo ""
echo "Step 5: Verify Installations"
echo "-----------------------------"
echo "Installed Adafruit libraries:"
pip3 list | grep adafruit

echo ""
echo "========================================================"
echo "Installation Complete!"
echo "========================================================"
echo ""
echo "Next Steps:"
echo "1. Wire I2C sensors to Raspberry Pi GPIO (see SETUP-GUIDE.md)"
echo "2. Run: i2cdetect -y 1"
echo "   Expected addresses: 0x23 (BH1750), 0x36 (STEMMA), 0x38 (DHT20)"
echo "3. Test sensors with: python3 ~/opengardenlab/firmware/tests/test_i2c_sensors.py"
echo ""
