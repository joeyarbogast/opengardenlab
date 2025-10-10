# OpenGardenLab MVP - Final Shopping List
**Date:** 2025-10-01
**Status:** Ready to Order
**Total Cost:** ~$110-121

---

## 🛒 Adafruit Order - $20.80 + shipping (~$27-29 total)

**Order at:** [Adafruit.com](https://www.adafruit.com)

| Item | Product # | Price | Link |
|------|-----------|-------|------|
| STEMMA Soil Moisture Sensor | 4026 | $6.95 | [Buy](https://www.adafruit.com/product/4026) |
| BH1750 Light Sensor | 4681 | $5.95 | [Buy](https://www.adafruit.com/product/4681) |
| **DHT20 Temp/Humidity Sensor** ⭐ | **5183** | **$5.95** | [Buy](https://www.adafruit.com/product/5183) |
| STEMMA QT Cables (2-pack) | 4209 | $1.95 | [Buy](https://www.adafruit.com/product/4209) |
| **Subtotal** | | **$20.80** | |
| Shipping | | ~$6-8 | |
| **TOTAL** | | **~$27-29** | |

### Optional Add-on:
| DS18B20 Waterproof Soil Temp Probe | 381 | $9.95 | [Buy](https://www.adafruit.com/product/381) |

**Notes:**
- DHT20 is the replacement for discontinued DHT22 - it's better (I2C, more accurate, cheaper)!
- STEMMA QT cables make wiring plug-and-play (no soldering)

---

## 🛒 Amazon Order - ~$83-92

**Search terms to find these items:**

### Core Components

| Item | Search Term | Approx Price | Notes |
|------|-------------|--------------|-------|
| **Raspberry Pi Zero 2 WH** | "raspberry pi zero 2 wh" | $16-20 | Pre-soldered headers |
| **MicroSD Card** | ❌ **You have this** | $0 | Use existing |
| **USB Power Banks (2×)** | "anker powercore 20000" | $40 (2× $20 ea) | 20,000mAh recommended |
| **Clear IP67 Junction Box** | (see below) | $15-20 | 8.7"×6.7"×4.3" size |
| **PG7 Cable Glands (5-pack)** | "pg7 cable gland" | $6-8 | For sensor wires |
| **Silicone Sealant** | "outdoor waterproof silicone" | $4-6 | For sealing cable glands |
| **Micro USB Cable** | ❌ **Check if you have one** | $3-5 (if needed) | Old phone charger works |

**Subtotal:** ~$83-97

### What You Already Have (Don't Buy!)
- ✅ Breadboard
- ✅ Jumper wires
- ✅ MicroSD cards
- ✅ Micro USB cable (probably)

### What You DON'T Need (Savings!)
- ❌ 10kΩ resistors (DHT20 has built-in pullups) - Save $3
- ❌ Clear acrylic sheet (clear box has transparent lid) - Save $3-5
- ❌ MCP3008 ADC chip (all sensors are I2C) - Save $4

**Total savings: ~$10-12 vs original plan!**

---

## 📦 Specific Product Links

### Clear IP67 Junction Box (8.7" × 6.7" × 4.3")

**The one you found:**
- Search Amazon for: "LeMotech Junction Box 8.7"
- **Features:** IP67 rated, clear cover (light sensor sees through!), 8.7"×6.7"×4.3" size
- **Price:** ~$15-20
- **Perfect size:** Fits Pi Zero + 20,000mAh battery + sensors

**Why this specific box:**
- ✅ IP67 (immersion-proof - better than IP65)
- ✅ Clear lid (no need to cut window for light sensor!)
- ✅ Large enough for 20,000mAh power bank
- ✅ Room to grow (future sensors)

---

### Raspberry Pi Zero 2 WH

**Search:** "raspberry pi zero 2 wh"

**What to verify:**
- ✅ "WH" model (Wireless + Headers pre-soldered)
- ✅ Price $16-20
- ✅ Official or trusted seller (CanaKit, Adafruit, etc.)

**Common sellers:**
- Amazon (various sellers)
- Adafruit.com (Product #5291)
- CanaKit
- PiShop.us

---

### USB Power Banks

**Search:** "anker powercore 20000"

**Recommended:** Anker PowerCore 20000 (or similar)
- **Capacity:** 20,000mAh minimum (10,000mAh works but swap more often)
- **Output:** 5V USB-A (standard)
- **Quantity:** Buy 2 (swap one while charging other)

**Why 20,000mAh:**
- Pi Zero uses ~14.4Wh/day
- 20,000mAh @ 5V = 100Wh
- **Battery life: ~7 days** (swap weekly)

**Alternative (budget):**
- 10,000mAh banks ($15 ea, $30 for 2)
- Battery life: ~3-4 days (swap twice weekly)

---

### PG7 Cable Glands

**Search:** "pg7 cable gland waterproof"

**What to look for:**
- Pack of 5-10 glands
- PG7 or M12 size (fits sensor cables)
- IP68 or IP67 rated
- $6-10 for 5-pack

**Why you need them:**
- Creates waterproof seal where sensor wires exit enclosure
- Screw-in design, easy to install
- Professional finish vs just drilling holes

**How many:** 3-4 glands (one per sensor wire bundle)

---

### Silicone Sealant

**Search:** "outdoor waterproof silicone sealant clear"

**What to look for:**
- 100% silicone
- Outdoor/weatherproof rated
- Clear or white color
- Small tube ($4-6)

**Common brands:**
- GE Silicone II
- DAP
- Gorilla Clear Silicone

**Usage:** Seal around cable glands, reinforce joints

---

## 💰 Cost Summary

| Category | Cost |
|----------|------|
| **Adafruit (sensors)** | $27-29 |
| **Amazon (core)** | $83-92 |
| **Optional DS18B20** | +$10 (if adding) |
| **TOTAL (without DS18B20)** | **$110-121** ✅ |
| **TOTAL (with DS18B20)** | **$123-131** |

**Original estimate:** $119-128
**Actual cost:** $110-121
**Savings:** ~$8-10 (thanks to DHT20 being cheaper and no resistors needed!)

---

## ✅ What You're Getting

### Sensors (4-5 measurements):
- ✅ Soil moisture (0-100%)
- ✅ Light intensity (1-65,535 lux)
- ✅ Air temperature (-40°C to 85°C)
- ✅ Air humidity (0-100% RH)
- ✅ Soil temperature (optional DS18B20 or built-in STEMMA Soil sensor)

### Hardware:
- ✅ Raspberry Pi Zero 2 WH (quad-core, WiFi, Bluetooth)
- ✅ IP67 waterproof clear enclosure
- ✅ 2× 20,000mAh power banks (7-day battery life each)
- ✅ Professional cable glands (waterproof wire entry)

### Advantages of This Setup:
- ✅ **All I2C sensors** - simple wiring, all share same 2 wires
- ✅ **No resistors needed** - DHT20 has built-in pullups
- ✅ **Clear enclosure** - light sensor sees through lid (no window cutting!)
- ✅ **IP67 rated** - immersion-proof for heavy rain
- ✅ **Room to grow** - large enclosure supports future sensors

---

## 📋 Shopping Checklist

### Before You Order:

- [ ] **Verify you have:** Breadboard, jumper wires, MicroSD cards, Micro USB cable
- [ ] **Choose power bank size:** 20,000mAh (weekly swap) or 10,000mAh (twice weekly)
- [ ] **Decide on DS18B20:** Add now or order later?

### Order Process:

**Step 1: Adafruit (~15 min)**
- [ ] Go to [Adafruit.com](https://www.adafruit.com)
- [ ] Add Product #4026 (STEMMA Soil) - $6.95
- [ ] Add Product #4681 (BH1750 Light) - $5.95
- [ ] Add Product #5183 (DHT20 Temp/Humidity) - $5.95 ⭐
- [ ] Add Product #4209 (STEMMA QT Cables) - $1.95
- [ ] Optional: Add Product #381 (DS18B20) - $9.95
- [ ] Checkout (shipping ~$6-8)
- [ ] **Expected delivery:** 3-7 days

**Step 2: Amazon (~15 min)**
- [ ] Search "raspberry pi zero 2 wh" → Add to cart ($16-20)
- [ ] Search "anker powercore 20000" → Add 2× to cart ($40)
- [ ] Search "LeMotech junction box 8.7" → Add clear IP67 box ($15-20)
- [ ] Search "pg7 cable gland" → Add 5-pack ($6-8)
- [ ] Search "outdoor silicone sealant" → Add clear/white ($4-6)
- [ ] Optional: Micro USB cable if needed ($3-5)
- [ ] Checkout with Prime (1-2 day shipping)
- [ ] **Expected delivery:** 1-3 days

---

## 🚀 Next Steps After Ordering

**While waiting for hardware (3-7 days):**

1. **Phase 2.1: PRD Development**
   - Transform to PM agent
   - Create Product Requirements Document
   - Define user stories and acceptance criteria

2. **Set up plant data structure**
   - Create `data/plants/` folder
   - Write YAML schema
   - Begin curating plant profiles (tomato, pepper, lettuce, basil)

3. **Learn Python basics** (if needed)
   - Refresh Python syntax from .NET background
   - Review Raspberry Pi GPIO basics

4. **Plan architecture**
   - System design for firmware + mobile app
   - Bluetooth sync protocol
   - Data storage schema

**Estimated time to working MVP:** 4-6 months part-time (after hardware arrives)

---

## 📞 Need Help?

**Questions about parts:**
- Post in Raspberry Pi forums
- Adafruit customer support
- Review product Q&A on Amazon

**Questions about project:**
- Continue to Phase 2: PRD Development
- Reference research docs in `docs/` folder

---

**Ready to order?** ✅

**Total investment:** ~$110-121 for a complete IoT garden monitoring system!

*Shopping list created 2025-10-01*

---

## 🔬 Future Experimental Components (Phase 2+)

Components to consider for expanding capabilities beyond MVP. These support advanced diagnostics, better accuracy, and automation experiments.

### 🌡️ Advanced Sensors

**High-Priority Environmental:**
| Component | Purpose | Est. Cost | Interface | Notes |
|-----------|---------|-----------|-----------|-------|
| **BME680** | 4-in-1: temp, humidity, pressure, air quality/VOC | $20 | I2C | Superior to DHT20, detects plant stress gases |
| **Capacitive pH Sensor** | Soil pH measurement (critical for nutrients) | $15-25 | I2C/Analog | High impact for plant diagnosis |
| **EC/TDS Sensor** | Electrical conductivity (nutrient concentration) | $15-20 | Analog | Requires ADC or analog-capable sensor |
| **NPK Sensor** | Direct N-P-K measurement | $40-80 | RS485/UART | Expensive but highly valuable |

**Specialty Light/Radiation:**
| Component | Purpose | Est. Cost | Interface | Notes |
|-----------|---------|-----------|-----------|-------|
| **VEML6075 UV Sensor** | UV index tracking for sun-sensitive plants | $8-12 | I2C | Adafruit #3964 |
| **AS7341 Spectral Sensor** | 11-channel light spectrum analyzer | $15-18 | I2C | Optimize photosynthesis wavelengths |
| **Thermal Camera (MLX90640 or AMG8833)** | Heat mapping for disease/water stress | $50-70 (MLX) / $40 (AMG) | I2C | MLX is 32×24px, AMG is 8×8px |

**Water/Weather:**
| Component | Purpose | Est. Cost | Interface | Notes |
|-----------|---------|-----------|-----------|-------|
| **Rain Gauge (Tipping Bucket)** | Measure rainfall | $12-18 | Digital pulse | Correlate watering with rain |
| **Wind Speed Sensor (Anemometer)** | Track wind damage risk | $15-25 | Analog/Pulse | Useful for exposed gardens |

### ⚡ Power & Connectivity

| Component | Purpose | Est. Cost | Notes |
|-----------|---------|-----------|-------|
| **Solar Panel Kit (6V 2W + charge controller)** | Eliminate battery swapping | $25-35 | Test solar feasibility earlier than Phase 2 |
| **DS3231 RTC Module** | Precision timestamps without WiFi | $3-6 | I2C, battery-backed clock |
| **LoRa Module (RFM95W)** | Long-range wireless (500m+) | $15-25 | SPI, Bluetooth alternative for large properties |

### 🔧 Expansion Hardware

| Component | Purpose | Est. Cost | Notes |
|-----------|---------|-----------|-------|
| **I2C Multiplexer (TCA9548A)** | Run multiple sensors with same I2C address | $5-8 | Essential for scaling sensors |
| **2-4 Channel Relay Module** | Automated watering valve experiments | $8-12 | 5V/3.3V compatible |
| **Breadboard Power Supply** | Clean 3.3V/5V rails during prototyping | $6-10 | MB102 module |

### 🛠️ Development & Accessories

**Testing Tools:**
| Component | Purpose | Est. Cost | Notes |
|-----------|---------|-----------|-------|
| **USB Logic Analyzer** | Debug I2C/1-Wire communication | $10-15 | Saleae-compatible 8-channel |
| **USB-C Power Meter** | Measure actual power draw for battery planning | $12-20 | Measure Pi + sensors current |

**Installation Accessories:**
| Component | Purpose | Est. Cost | Notes |
|-----------|---------|-----------|-------|
| **Waterproof Cable Glands (extra)** | Better sealing than IP65 box alone | $6-8 | PG9 or PG11 for larger cables |
| **STEMMA QT/Qwiic Cables** (various lengths: 50mm, 100mm, 200mm) | Tool-free I2C prototyping | $2-3 each | Adafruit or SparkFun |
| **Heat-Shrink Tubing Kit** | Professional wire terminations | $8-12 | Various sizes |
| **Wire Ferrules + Crimper** | Clean sensor wire connections | $15-20 | Prevents fraying |
| **Silica Gel Packets (reusable)** | Combat condensation in enclosure | $8-12 | Rechargeable desiccant |
| **Spare MicroSD Cards (16-32GB)** | Quick firmware version swapping | $6-10 each | High-endurance recommended |

### 💡 Recommended First Additions (Budget: $100-150)

If adding components after MVP deployment, prioritize these for maximum impact:

1. **pH Sensor** ($15-25) - Critical missing data point for plant health
2. **BME680** ($20) - Replace DHT20 with superior multi-sensor
3. **Solar Panel Kit** ($25-35) - Biggest quality-of-life improvement
4. **I2C Multiplexer** ($5) - Future-proofs multi-sensor expansion
5. **Spare Sensors** ($20-30) - STEMMA Soil + BH1750 backups (outdoor failures happen)
6. **Logic Analyzer** ($10-15) - Invaluable for debugging sensor issues

**Total:** ~$95-130 for high-impact expansion

### 📝 Notes on Future Sensors

**I2C Compatibility:**
- Most recommended sensors use I2C (shares same 2-wire bus as current sensors)
- I2C multiplexer allows duplicate addresses (e.g., multiple BH1750 sensors)

**Analog Sensors (EC/TDS, Wind):**
- Raspberry Pi Zero has NO built-in ADC
- Options: Add MCP3008 ADC chip ($4) OR use I2C ADC module (ADS1115, $10)
- Consider ESP32 for analog-heavy Phase 3 multi-node setup

**Power Budget:**
- BME680, pH sensor, UV sensor add minimal power draw (~5-10mA each)
- Thermal camera (MLX90640) draws ~20mA (still acceptable)
- Solar panel becomes critical if adding 5+ sensors

**Storage:**
- Additional sensors increase data volume (more columns per reading)
- 32GB MicroSD handles years of expanded data (current estimate: ~500KB/month)

---

*Future components list added 2025-10-05*
