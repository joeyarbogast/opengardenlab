# Sensor Selection Research: OpenGardenLab
**Architect:** Winston
**Date:** 2025-10-01
**Status:** Final
**Project:** OpenGardenLab IoT Garden Monitoring System

---

## Executive Summary

This research evaluates specific sensor models for OpenGardenLab MVP, focusing on **soil moisture**, **light intensity**, and **temperature** measurements. All sensors are evaluated for compatibility with **Raspberry Pi Zero 2 WH**, accuracy, durability, cost, and ease of integration.

### Final Recommendations (UPDATED 2025-10-01)

| **Sensor Type** | **Recommended Model** | **Interface** | **Cost** | **Key Benefit** |
|-----------------|----------------------|---------------|----------|-----------------|
| **Soil Moisture** | Adafruit STEMMA Soil Sensor (Capacitive) | I2C | $7 | No corrosion, I2C digital (no ADC needed) |
| **Light (LUX)** | Adafruit BH1750 | I2C | $6 | Accurate LUX, low power, I2C |
| **Temperature (Air)** | **Adafruit DHT20 (AHT20)** ⭐ | **I2C** | **$6** | **I2C interface, more accurate, cheaper** |
| **Temperature (Soil)** | DS18B20 Waterproof Probe | 1-Wire | $10 | Waterproof, accurate, easy 1-Wire |

**Total sensor cost per device:** ~$19-29 (without/with optional DS18B20)

**UPDATE:** DHT22 discontinued - replaced with **DHT20 (AHT20)** which is BETTER:
- ✅ **I2C interface** (vs custom protocol) - shares bus with other sensors
- ✅ **More accurate** (±0.3°C vs ±0.5°C)
- ✅ **Cheaper** ($6 vs $10 - saves $4!)
- ✅ **STEMMA QT connector** (plug-and-play)
- ✅ **No pullup resistor needed** (built-in)

**Key insight:** By choosing **all I2C digital sensors**, we can **avoid the MCP3008 ADC entirely** AND **no resistors needed** for MVP, simplifying hardware and reducing cost.

---

## Soil Moisture Sensors

### Overview

Soil moisture is the **most critical sensor** for OpenGardenLab. Two primary technologies exist:

1. **Resistive sensors:** Measure resistance between two probes
2. **Capacitive sensors:** Measure capacitance of surrounding soil (no direct contact)

### Resistive vs Capacitive Comparison

| **Criterion** | **Resistive** | **Capacitive** |
|---------------|---------------|----------------|
| **Corrosion** | ❌ High (exposed metal degrades in weeks-months) | ✅ Low (coated PCB, no exposed probes) |
| **Longevity** | 3-6 months outdoor | 2-5+ years |
| **Accuracy** | ⚠️ Degrades as probes corrode | ✅ Stable over time |
| **Cost** | $2-5 | $5-10 |
| **Interface** | Analog (needs ADC) | Analog or I2C |
| **Calibration drift** | High | Low |

**Verdict:** Capacitive sensors are **strongly recommended** for outdoor long-term deployment despite higher cost.

---

## Recommended Soil Moisture Sensors

### Option 1: Adafruit STEMMA Soil Sensor (Capacitive) ⭐ RECOMMENDED

**Model:** Adafruit Product ID 4026
**Cost:** $6.95

**Specifications:**
- **Technology:** Capacitive (no corrosion)
- **Interface:** I2C (address 0x36)
- **Output:** Digital values (0-1023 raw, converted to percentage)
- **Power:** 3.3V or 5V (Pi Zero uses 3.3V)
- **Connector:** STEMMA QT / Qwiic (I2C plug-and-play, no soldering)
- **Size:** 100mm probe length
- **Additional:** Built-in temperature sensor (bonus!)

**Pros:**
- ✅ **I2C digital interface** - no ADC needed, just 2 wires (SDA/SCL)
- ✅ **STEMMA connector** - plug-and-play with cable (no breadboard for production)
- ✅ **Capacitive** - long-term durability (2-5 years)
- ✅ **Built-in temp sensor** - bonus soil temperature reading
- ✅ **Python library** - Adafruit CircuitPython support
- ✅ **Extensive documentation** - tutorials, calibration guides

**Cons:**
- ⚠️ More expensive than generic capacitive ($7 vs $3-4)
- ⚠️ STEMMA cable adds $1-2 (or solder directly to save cost)

**Python Example:**
```python
import board
import adafruit_seesaw.seesaw

i2c = board.I2C()
ss = adafruit_seesaw.seesaw.Seesaw(i2c, addr=0x36)

# Read moisture (0-1023 raw)
moisture = ss.moisture_read()
moisture_pct = (moisture / 1023.0) * 100

# Bonus: soil temperature
temp_c = ss.get_temp()

print(f"Moisture: {moisture_pct:.1f}%")
print(f"Soil Temp: {temp_c:.1f}°C")
```

**Recommended:** ⭐⭐⭐⭐⭐ **Best for MVP** (I2C simplicity + durability + bonus temp)

---

### Option 2: DFRobot Capacitive Soil Moisture Sensor v2.0

**Model:** DFRobot SEN0193
**Cost:** $6.90

**Specifications:**
- **Technology:** Capacitive
- **Interface:** Analog (0-3V output)
- **Power:** 3.3V-5.5V
- **Size:** 98mm probe length
- **Connector:** 3-pin cable (VCC, GND, AOUT)

**Pros:**
- ✅ **Capacitive** - corrosion-resistant
- ✅ **Widely available** - Amazon, DFRobot, Adafruit
- ✅ **Good reviews** - reliable outdoor performance
- ✅ **Affordable** - $6-7

**Cons:**
- ❌ **Analog interface** - requires MCP3008 ADC ($4) or ADS1115 ADC
- ⚠️ No built-in temp sensor
- ⚠️ Requires calibration (air = dry, water = wet)

**Python Example (with MCP3008 ADC):**
```python
from gpiozero import MCP3008

moisture_sensor = MCP3008(channel=0)  # Connected to MCP3008 channel 0

raw = moisture_sensor.value  # 0.0 to 1.0
moisture_pct = raw * 100

print(f"Moisture: {moisture_pct:.1f}%")
```

**Recommended:** ⭐⭐⭐⭐ Good alternative if you need analog for other sensors

---

### Option 3: Generic Capacitive Soil Moisture Sensor v1.2

**Model:** Various brands (Amazon, AliExpress)
**Cost:** $3-5 (often sold in packs of 5 for $12-15)

**Specifications:**
- **Technology:** Capacitive
- **Interface:** Analog (0-3V output)
- **Power:** 3.3V-5V
- **Size:** 98mm probe length
- **Quality:** Variable (depends on brand)

**Pros:**
- ✅ **Very affordable** - $3-5 each, $2-3 in bulk
- ✅ **Capacitive** - better than resistive
- ✅ **Good for prototyping** - cheap to test and calibrate

**Cons:**
- ❌ **Quality varies** - some units fail quickly
- ❌ **Analog interface** - requires ADC
- ⚠️ **No official library** - generic code only
- ⚠️ **Calibration required** - readings inconsistent between units

**Recommended:** ⭐⭐⭐ Budget option for testing, but Adafruit STEMMA better for production

---

### Avoid: Resistive Soil Moisture Sensors

**Example:** YL-69, FC-28, generic 2-probe sensors
**Cost:** $2-3

**Why avoid:**
- ❌ **Corrode rapidly** - exposed metal probes degrade in weeks (especially in fertilized soil)
- ❌ **Inaccurate over time** - readings drift as corrosion increases
- ❌ **Short lifespan** - 1-6 months outdoor, then unusable
- ❌ **Not worth the savings** - $2 cheaper but must replace every few months

**Verdict:** False economy. Spend $5 more on capacitive for years of reliable data.

---

## Light Sensors (LUX Measurement)

### Overview

Light sensors measure **illuminance** in **lux** (lumens per square meter). For garden monitoring, we need:
- **Range:** 0-50,000 lux (full sunlight ~32,000-100,000 lux)
- **Accuracy:** ±20% sufficient for plant care (not scientific-grade)
- **Interface:** I2C preferred (digital, easy to read)

### Recommended Light Sensors

### Option 1: Adafruit BH1750 Light Sensor ⭐ RECOMMENDED

**Model:** Adafruit Product ID 4681
**Cost:** $5.95

**Specifications:**
- **Sensor chip:** BH1750FVI (ROHM Semiconductor)
- **Interface:** I2C (address 0x23)
- **Range:** 1-65,535 lux
- **Resolution:** 1 lux
- **Accuracy:** ±20%
- **Power:** 3.3V or 5V
- **Connector:** STEMMA QT / Qwiic (plug-and-play)

**Pros:**
- ✅ **I2C digital** - simple 2-wire interface
- ✅ **Wide range** - 1 to 65,535 lux (covers shade to full sun)
- ✅ **Low power** - 120µA active, 1µA standby
- ✅ **STEMMA connector** - plug-and-play
- ✅ **Python library** - Adafruit CircuitPython support
- ✅ **Automatic ranging** - adjusts sensitivity automatically

**Cons:**
- ⚠️ Slightly more expensive than TSL2561 ($6 vs $5)
- ⚠️ Not weatherproof (must be in enclosure, sensor near clear window/acrylic)

**Python Example:**
```python
import board
import adafruit_bh1750

i2c = board.I2C()
sensor = adafruit_bh1750.BH1750(i2c)

lux = sensor.lux
print(f"Light: {lux:.1f} lux")

# Interpret for plants
if lux < 1000:
    print("Shade")
elif lux < 10000:
    print("Partial sun")
else:
    print("Full sun")
```

**Recommended:** ⭐⭐⭐⭐⭐ **Best choice** (I2C, wide range, low power, well-supported)

---

### Option 2: Adafruit TSL2561 Light Sensor

**Model:** Adafruit Product ID 439
**Cost:** $4.95

**Specifications:**
- **Sensor chip:** TSL2561 (Texas Instruments)
- **Interface:** I2C (address 0x39 or 0x29)
- **Range:** 0.1-40,000 lux
- **Power:** 3.3V or 5V

**Pros:**
- ✅ **I2C digital**
- ✅ **Slightly cheaper** - $5 vs $6
- ✅ **Python library** - well-supported
- ✅ **Infrared compensation** - filters IR light for more accurate visible light reading

**Cons:**
- ⚠️ **Lower max range** - 40,000 lux (may clip in direct summer sun ~100,000 lux)
- ⚠️ **Being phased out** - TSL2561 chip discontinued, BH1750 recommended replacement

**Recommended:** ⭐⭐⭐⭐ Good, but BH1750 is newer and better supported

---

### Option 3: Analog Photoresistor (LDR)

**Model:** Generic photoresistor (CdS cell)
**Cost:** $1-2

**Specifications:**
- **Technology:** Cadmium Sulfide (CdS) photoresistor
- **Interface:** Analog (resistance changes with light)
- **Range:** Qualitative (not calibrated to lux)

**Pros:**
- ✅ **Very cheap** - $1-2
- ✅ **Simple circuit** - voltage divider with resistor

**Cons:**
- ❌ **No lux measurement** - relative brightness only (not calibrated)
- ❌ **Requires ADC** - analog interface
- ❌ **Nonlinear response** - hard to convert to actual lux values
- ❌ **Not accurate** - readings vary by temperature, age
- ❌ **Contains cadmium** - environmental concern

**Recommended:** ⭐⭐ Avoid for production. Use BH1750 instead.

---

## Temperature Sensors

### Overview

OpenGardenLab needs **two temperature measurements**:
1. **Air temperature** - ambient garden conditions
2. **Soil temperature** - root zone temperature (affects nutrient uptake, germination)

**Ideal sensor characteristics:**
- **Range:** -10°C to 50°C (14°F to 122°F) covers most garden conditions
- **Accuracy:** ±0.5-1°C sufficient
- **Waterproof:** Required for outdoor deployment
- **Interface:** I2C or 1-Wire (digital, easy to read)

---

### Air Temperature Sensors

### Option 1: Adafruit DHT20 (AHT20) ⭐ **RECOMMENDED** (UPDATED 2025-10-01)

**Model:** Adafruit Product ID 5183
**Cost:** $5.95

**STATUS:** DHT22 discontinued by Adafruit - **DHT20 is the recommended replacement and is BETTER in every way!**

**Specifications:**
- **Sensor chip:** AHT20 (also sold as DHT20)
- **Interface:** **I2C** (address 0x38) ⭐ **Major improvement over DHT22**
- **Measurements:** Temperature + Humidity
- **Range (Temp):** -40°C to 85°C (-40°F to 185°F)
- **Accuracy (Temp):** **±0.3°C** ⭐ (better than DHT22's ±0.5°C)
- **Range (Humidity):** 0-100% RH
- **Accuracy (Humidity):** ±2% RH
- **Power:** 3.3V or 5V
- **Connector:** STEMMA QT / Qwiic (plug-and-play)

**Pros:**
- ✅ **I2C interface** - shares bus with STEMMA Soil + BH1750 (no extra GPIO needed!)
- ✅ **More accurate** - ±0.3°C vs ±0.5°C (DHT22)
- ✅ **Cheaper** - $6 vs $10 (saves $4!)
- ✅ **STEMMA QT connector** - plug-and-play with cable
- ✅ **No pullup resistor needed** - built-in
- ✅ **More reliable** - standard I2C protocol vs custom DHT protocol
- ✅ **Temperature + Humidity** - two sensors in one
- ✅ **Python library** - Adafruit CircuitPython AHTx0 library

**Cons:**
- None! This is a pure upgrade from DHT22

**Python Example:**
```python
import board
import adafruit_ahtx0

i2c = board.I2C()  # Same I2C bus as other sensors
sensor = adafruit_ahtx0.AHTx0(i2c)

temp_c = sensor.temperature
humidity = sensor.relative_humidity
print(f"Temp: {temp_c:.1f}°C, Humidity: {humidity:.1f}%")
```

**Recommended:** ⭐⭐⭐⭐⭐ **Best for air temp** (I2C, more accurate, cheaper, plug-and-play)

**Link:** [Adafruit DHT20 #5183](https://www.adafruit.com/product/5183)

---

### Option 2: DHT22 (AM2302) - DISCONTINUED ❌

**Model:** Adafruit Product ID 385
**Status:** **No longer stocked** - replaced by DHT20

**If you already own DHT22:** Still works, but DHT20 is better. Consider upgrading.

**Cons vs DHT20:**
- ❌ **Custom protocol** (not I2C) - requires dedicated GPIO pin
- ❌ **Less accurate** - ±0.5°C vs ±0.3°C
- ❌ **More expensive** - was $10 vs $6
- ❌ **Needs pullup resistor** - 10kΩ external resistor required
- ❌ **Less reliable** - timing-sensitive protocol causes occasional read failures

---

### Option 2: DHT11 (Cheaper Alternative)

**Model:** Generic DHT11
**Cost:** $3-5

**Specifications:**
- **Range (Temp):** 0°C to 50°C
- **Accuracy (Temp):** ±2°C (worse than DHT22)
- **Range (Humidity):** 20-80% RH
- **Accuracy (Humidity):** ±5% RH

**Pros:**
- ✅ **Cheap** - $3-5
- ✅ **Same interface as DHT22** - same Python library

**Cons:**
- ❌ **Less accurate** - ±2°C vs ±0.5°C
- ❌ **Narrower range** - 0-50°C (won't handle freezing temps)
- ❌ **Lower humidity accuracy** - ±5% vs ±2-5%

**Recommended:** ⭐⭐⭐ Budget option, but DHT22 worth the $5 extra for better accuracy

---

### Soil Temperature Sensors

### Option 1: DS18B20 Waterproof Temperature Probe ⭐ RECOMMENDED

**Model:** DS18B20 in waterproof stainless steel probe
**Cost:** $9-12

**Specifications:**
- **Sensor chip:** Dallas DS18B20
- **Interface:** 1-Wire (Dallas/Maxim 1-Wire protocol)
- **Range:** -55°C to 125°C (-67°F to 257°F)
- **Accuracy:** ±0.5°C (-10°C to 85°C)
- **Resolution:** 9-12 bit (0.5°C to 0.0625°C)
- **Probe:** Stainless steel, waterproof
- **Cable length:** 1-3 meters (various options)
- **Power:** 3.3V-5V

**Pros:**
- ✅ **Waterproof** - stainless steel probe, sealed cable
- ✅ **Accurate** - ±0.5°C
- ✅ **1-Wire protocol** - multiple sensors on one GPIO pin
- ✅ **Python library** - w1thermsensor library
- ✅ **Long cable** - probe can be deep in soil, Pi in enclosure above ground
- ✅ **Durable** - stainless steel, long lifespan
- ✅ **Unique ID** - each sensor has 64-bit ID (supports multiple sensors)

**Cons:**
- ⚠️ **Requires 4.7kΩ pullup resistor** (one resistor for all 1-Wire sensors)
- ⚠️ **1-Wire can be finicky** - interference can cause read errors (rare)

**Python Example:**
```python
from w1thermsensor import W1ThermSensor

sensor = W1ThermSensor()
temp_c = sensor.get_temperature()
temp_f = sensor.get_temperature(W1ThermSensor.DEGREES_F)

print(f"Soil Temp: {temp_c:.1f}°C ({temp_f:.1f}°F)")
```

**Setup on Raspberry Pi:**
```bash
# Enable 1-Wire interface
sudo raspi-config
# Interface Options → 1-Wire → Enable

# Install library
pip3 install w1thermsensor
```

**Recommended:** ⭐⭐⭐⭐⭐ **Best for soil temp** (waterproof, accurate, easy to use)

---

### Option 2: Adafruit STEMMA Soil Sensor (Built-in Temp)

**Already recommended for soil moisture!**

The Adafruit STEMMA Soil Sensor (Product ID 4026) includes a **built-in temperature sensor** in addition to capacitive moisture.

**Specifications (Temp):**
- **Range:** -40°C to 125°C
- **Accuracy:** ±2°C
- **Interface:** I2C (same as moisture reading)

**Pros:**
- ✅ **Two sensors in one** - moisture + soil temp
- ✅ **I2C** - simple interface
- ✅ **No extra cost** - already buying for moisture

**Cons:**
- ⚠️ **Less accurate** - ±2°C vs ±0.5°C for DS18B20
- ⚠️ **Single point measurement** - temp sensor at same depth as moisture probe

**Recommended:** ⭐⭐⭐⭐ Good if using STEMMA soil sensor (free bonus temp)

---

## Final Sensor Recommendations for MVP

### Recommended Sensor Kit (I2C/Digital Focus)

| **Sensor** | **Model** | **Interface** | **Cost** | **Measurement** |
|------------|-----------|---------------|----------|-----------------|
| **Soil Moisture** | Adafruit STEMMA Soil Sensor (4026) | I2C | $7 | Moisture + Soil Temp |
| **Light** | Adafruit BH1750 (4681) | I2C | $6 | Lux (0-65,535) |
| **Air Temp/Humidity** | Adafruit DHT22 (385) | Digital GPIO | $10 | Temp + Humidity |
| **Soil Temp (optional)** | DS18B20 Waterproof Probe | 1-Wire | $10 | Soil Temp (more accurate) |
| **TOTAL (without DS18B20)** | | | **$23** | 4 measurements |
| **TOTAL (with DS18B20)** | | | **$33** | 5 measurements |

**Optional accessories:**
- STEMMA QT cables (I2C): $1-2 each (for plug-and-play connections)
- Breadboard: $5-8 (prototyping)
- Jumper wires: $5 (prototyping)

---

## Interface Summary (Pi Zero 2 WH Compatibility)

### I2C Sensors (Recommended)

**Sensors:** Adafruit STEMMA Soil, BH1750 Light

**Wiring (for each I2C sensor):**
- VCC → Pi Pin 1 (3.3V)
- GND → Pi Pin 6 (Ground)
- SDA → Pi Pin 3 (GPIO2, I2C SDA)
- SCL → Pi Pin 5 (GPIO3, I2C SCL)

**Advantages:**
- ✅ All I2C sensors share 2 wires (SDA, SCL)
- ✅ No ADC needed (saves $4 + wiring complexity)
- ✅ Digital readings (more accurate, no calibration drift)
- ✅ Up to ~100 devices on one I2C bus (future expansion easy)

**Python Setup:**
```bash
# Enable I2C
sudo raspi-config
# Interface Options → I2C → Enable

# Install libraries
pip3 install adafruit-circuitpython-seesaw  # STEMMA soil
pip3 install adafruit-circuitpython-bh1750  # BH1750 light
```

---

### Digital GPIO Sensors

**Sensor:** DHT22 (air temp/humidity)

**Wiring:**
- VCC → Pi Pin 1 (3.3V)
- GND → Pi Pin 6 (Ground)
- Data → Pi Pin 7 (GPIO4)
- 10kΩ resistor between Data and VCC (pullup)

**Python Setup:**
```bash
pip3 install adafruit-circuitpython-dht
sudo apt-get install libgpiod2  # Required dependency
```

---

### 1-Wire Sensors

**Sensor:** DS18B20 (soil temp probe)

**Wiring:**
- Red (VCC) → Pi Pin 1 (3.3V)
- Black (GND) → Pi Pin 6 (Ground)
- Yellow (Data) → Pi Pin 7 (GPIO4)
- 4.7kΩ resistor between Data and VCC (pullup)

**Python Setup:**
```bash
# Enable 1-Wire interface
sudo raspi-config
# Interface Options → 1-Wire → Enable

pip3 install w1thermsensor
```

**Note:** DHT22 and DS18B20 can share GPIO4 (if needed), but use different libraries/protocols.

---

## Alternative: Budget Sensor Kit (Analog)

If you want to save money or already have analog sensors:

| **Sensor** | **Model** | **Interface** | **Cost** |
|------------|-----------|---------------|----------|
| **Soil Moisture** | Generic Capacitive v1.2 | Analog | $3-5 |
| **Light** | Photoresistor (LDR) | Analog | $1-2 |
| **Temperature** | LM35 or TMP36 | Analog | $2-3 |
| **ADC** | MCP3008 (8-channel 10-bit) | SPI | $4 |
| **TOTAL** | | | **$10-14** |

**Pros:**
- ✅ **Cheaper** - $10-14 vs $23-33

**Cons:**
- ❌ **Less accurate** - analog drift, no calibration
- ❌ **More complex wiring** - breadboard required, more connections
- ❌ **No humidity** - must add separate sensor
- ❌ **Less durable** - generic sensors fail sooner
- ❌ **More calibration** - each sensor needs calibration

**Recommendation:** Not worth the savings. Spend $15-20 more for **I2C digital sensors** that are easier to code, more accurate, and more reliable.

---

## Sensor Calibration

### Soil Moisture Calibration

**Why calibrate:** Raw sensor values don't directly map to soil moisture percentage. Calibration creates mapping: sensor value → % moisture.

**Calibration procedure (STEMMA Soil Sensor):**

1. **Air reading (0% moisture):**
   - Remove sensor from soil, let dry completely
   - Record reading (e.g., `moisture_raw = 200`)
   - This is 0% moisture

2. **Water reading (100% moisture):**
   - Submerge sensor in water (don't submerge electronics!)
   - Record reading (e.g., `moisture_raw = 1023`)
   - This is 100% moisture (saturated)

3. **Create mapping function:**
   ```python
   AIR_VALUE = 200    # From step 1
   WATER_VALUE = 1023  # From step 2

   def calibrate_moisture(raw):
       # Linear interpolation
       moisture_pct = ((raw - AIR_VALUE) / (WATER_VALUE - AIR_VALUE)) * 100
       return max(0, min(100, moisture_pct))  # Clamp to 0-100%
   ```

4. **Validate:**
   - Test in moist soil (should read 40-60%)
   - Test in dry soil (should read 10-30%)

**Recommendation:** Calibrate once during setup, save values to config file.

---

### Light Sensor Calibration

**BH1750:** Pre-calibrated to lux values. No calibration needed!

**Validation:**
- Full sun: 32,000-100,000 lux
- Partial shade: 10,000-20,000 lux
- Full shade: 1,000-5,000 lux
- Indoors: 100-500 lux

---

### Temperature Sensor Calibration

**DHT22 and DS18B20:** Pre-calibrated. Accuracy is ±0.5°C.

**Optional validation:**
- Compare to known thermometer
- Typical offset: ±1-2°C (acceptable for garden monitoring)

---

## Sensor Placement Best Practices

### Soil Moisture Sensor

**Placement:**
- **Depth:** 2-4 inches (5-10 cm) - root zone depth for most vegetables
- **Location:** Midway between plant stem and edge of root zone
- **Avoid:** Don't place against stem (rot risk), or at very edge (misses root zone)

**Installation:**
- Insert vertically or at 45° angle
- Ensure full probe length is in soil
- Avoid air gaps around probe

---

### Light Sensor

**Placement:**
- **Location:** Above plant canopy, facing upward
- **Height:** 6-12 inches above soil (or plant height)
- **Enclosure:** Place near clear window/acrylic in waterproof enclosure (sensor not weatherproof)
- **Avoid:** Don't place under leaves (shading), or facing specific direction (want omnidirectional)

**Tip:** For accurate readings, use clear acrylic/polycarbonate window in enclosure (not frosted).

---

### Temperature Sensors

**Air Temperature (DHT22):**
- **Location:** Shaded location, 4-6 inches above soil
- **Avoid:** Direct sunlight (reads higher than actual air temp)
- **Enclosure:** In ventilated enclosure (allow airflow, but protect from rain)

**Soil Temperature (DS18B20):**
- **Depth:** 2-4 inches (same depth as roots)
- **Location:** Near soil moisture sensor (correlate data)
- **Installation:** Insert probe horizontally into soil (long cable allows Pi enclosure to be above ground)

---

## Multi-Sensor Wiring Diagram

### I2C + Digital Setup (Recommended)

```
Raspberry Pi Zero 2 WH
┌─────────────────────────────────┐
│  Pin 1 (3.3V) ────┬──────┬──────┼─── All sensor VCC
│  Pin 3 (SDA)  ────┼──┬───┼──────┼─── I2C Data (STEMMA, BH1750)
│  Pin 5 (SCL)  ────┼──┼───┼──────┼─── I2C Clock (STEMMA, BH1750)
│  Pin 6 (GND)  ────┴──┴───┴──────┼─── All sensor GND
│  Pin 7 (GPIO4) ───────────────────── DHT22 Data (+ 10kΩ pullup to 3.3V)
│                                      DS18B20 Data (+ 4.7kΩ pullup to 3.3V)
└─────────────────────────────────┘

Sensors:
1. Adafruit STEMMA Soil (I2C 0x36): VCC, GND, SDA, SCL
2. Adafruit BH1750 Light (I2C 0x23): VCC, GND, SDA, SCL
3. DHT22 Air Temp/Humidity: VCC, GND, Data (GPIO4), 10kΩ pullup
4. DS18B20 Soil Temp (optional): VCC, GND, Data (GPIO4), 4.7kΩ pullup
```

**Notes:**
- All I2C sensors share SDA and SCL (just 2 wires for all I2C devices!)
- DHT22 and DS18B20 can share GPIO4 (different protocols, different libraries)
- Total GPIO pins used: 3 (SDA, SCL, GPIO4)
- No breadboard needed for production (STEMMA connectors + direct wire to DHT22/DS18B20)

---

## Cost Summary

### Recommended MVP Sensor Kit

| **Item** | **Cost** |
|----------|----------|
| Adafruit STEMMA Soil Sensor | $7 |
| Adafruit BH1750 Light Sensor | $6 |
| Adafruit DHT22 Temp/Humidity | $10 |
| **Subtotal (3 sensors, 4 measurements)** | **$23** |
| | |
| Optional: DS18B20 Soil Temp (more accurate) | $10 |
| Optional: STEMMA QT cables (2x) | $2-4 |
| Optional: Breadboard (prototyping) | $5-8 |
| Optional: Jumper wires | $5 |
| **Full kit** | **$45-50** |

**Per device (production):**
- Sensors only: $23-33
- Add Pi Zero 2 WH ($18) + MicroSD ($10) + Power bank ($20): **$71-91 total**

---

## Sensor Longevity & Maintenance

### Expected Lifespan (Outdoor Deployment)

| **Sensor** | **Expected Life** | **Failure Mode** | **Mitigation** |
|------------|-------------------|------------------|----------------|
| **STEMMA Soil (Capacitive)** | 2-5 years | Coating degrades, PCB corrosion | Keep in soil (don't dry out), avoid fertilizer contact |
| **BH1750 Light** | 5+ years | Electronics failure (rare) | Keep dry in enclosure |
| **DHT22** | 3-5 years | Humidity sensor drift | Replace when readings drift >5% |
| **DS18B20** | 5-10 years | Cable damage, connector corrosion | Strain relief, seal connections |

### Maintenance Schedule

**Monthly:**
- Check sensor connections (loose wires?)
- Verify readings are sensible (compare to manual check)

**Quarterly:**
- Recalibrate soil moisture (air + water test)
- Clean light sensor window (dust, pollen)

**Annually:**
- Replace DHT22 if humidity accuracy degrades
- Inspect soil sensor coating (visible damage?)

---

## Alternative Sensors (Future Consideration)

### Post-MVP Sensors (Phase 2+)

| **Sensor Type** | **Example** | **Cost** | **Benefit** |
|-----------------|-------------|----------|-------------|
| **Soil NPK (Nitrogen, Phosphorus, Potassium)** | RS485 NPK sensor | $50-100 | Nutrient monitoring |
| **Soil pH** | Analog pH probe + module | $20-40 | Acidity monitoring |
| **Camera Module** | Pi Camera Module 3 | $25 | Visual pest/disease detection |
| **Rain Gauge** | Tipping bucket rain sensor | $15-30 | Precipitation tracking |
| **Wind Speed** | Anemometer | $20-40 | Microclimate analysis |
| **Barometric Pressure** | BME280 (I2C) | $10 | Weather prediction |

**Not recommended for MVP:** Adds complexity, cost, and calibration burden. Focus on core sensors (moisture, light, temp) first.

---

## Shopping List (Copy-Paste Ready)

### Amazon/Adafruit Shopping Cart

**MVP Sensors (I2C/Digital):**
- [ ] Adafruit STEMMA Soil Sensor (Product ID 4026) - $7
- [ ] Adafruit BH1750 Light Sensor (Product ID 4681) - $6
- [ ] Adafruit DHT22 Temperature/Humidity Sensor (Product ID 385) - $10
- [ ] DS18B20 Waterproof Temperature Probe (Amazon or Adafruit) - $10

**Accessories:**
- [ ] STEMMA QT / Qwiic Cable (100mm, 2-pack) - Adafruit 4209 - $2
- [ ] 10kΩ resistor (for DHT22 pullup) - pack of 25 - $3
- [ ] 4.7kΩ resistor (for DS18B20 pullup) - pack of 25 - $3
- [ ] Breadboard (400 tie-points) - $5
- [ ] Jumper wires (male-to-female, 40-pack) - $5

**Total:** ~$50-55

**Where to buy:**
- **Adafruit:** [adafruit.com](https://www.adafruit.com/) (best for official breakouts, excellent docs)
- **Amazon:** Faster shipping, similar prices
- **SparkFun:** Alternative to Adafruit (sparkfun.com)
- **AliExpress/eBay:** Budget generics (longer shipping, variable quality)

---

## Next Steps

1. ✅ **Sensor Selection Complete:** I2C digital sensors recommended for simplicity and accuracy
2. **Order sensors:** Purchase recommended sensor kit (~$50-55)
3. **Plant Database Research (Next):** Identify sources for plant care data (optimal ranges per species)
4. **PRD Development:** PM agent creates Product Requirements Document
5. **Architecture Design:** System architecture (Python firmware + sensors + mobile app sync)
6. **Prototype Testing:** Once hardware arrives, test each sensor individually before integration

---

## Appendices

### A. I2C Address Reference

| **Sensor** | **I2C Address** | **Configurable?** |
|------------|-----------------|-------------------|
| Adafruit STEMMA Soil | 0x36 | No |
| Adafruit BH1750 | 0x23 | Via ADDR pin (0x23 or 0x5C) |
| DHT22 | N/A (not I2C) | N/A |
| DS18B20 | N/A (1-Wire) | Each has unique 64-bit ID |

**No conflicts!** Both I2C sensors have different addresses (can coexist on same bus).

### B. Power Consumption

| **Sensor** | **Active Current** | **Notes** |
|------------|-------------------|-----------|
| STEMMA Soil | ~5mA | I2C |
| BH1750 | ~0.12mA | Very low power |
| DHT22 | ~1.5mA | Only during reading (2s intervals) |
| DS18B20 | ~1.5mA | During conversion (~750ms) |
| **Total** | **~8-10mA** | All sensors active |

**Impact on battery life:** Negligible. Sensors use <10mA, Pi Zero uses 100-400mA. Sensor power is <5% of total.

### C. Sensor Datasheets

**Adafruit STEMMA Soil Sensor:**
- [Adafruit Learn Guide](https://learn.adafruit.com/adafruit-stemma-soil-sensor-i2c-capacitive-moisture-sensor)
- [CircuitPython Library](https://github.com/adafruit/Adafruit_CircuitPython_seesaw)

**BH1750 Light Sensor:**
- [Adafruit Learn Guide](https://learn.adafruit.com/adafruit-bh1750-ambient-light-sensor)
- [CircuitPython Library](https://github.com/adafruit/Adafruit_CircuitPython_BH1750)

**DHT22:**
- [Adafruit Learn Guide](https://learn.adafruit.com/dht)
- [CircuitPython Library](https://github.com/adafruit/Adafruit_CircuitPython_DHT)

**DS18B20:**
- [w1thermsensor Documentation](https://github.com/timofurrer/w1thermsensor)
- [Dallas DS18B20 Datasheet](https://datasheets.maximintegrated.com/en/ds/DS18B20.pdf)

---

*Sensor Selection Research completed using the BMAD-METHOD™ framework*
*Architect: Winston | Date: 2025-10-01*
