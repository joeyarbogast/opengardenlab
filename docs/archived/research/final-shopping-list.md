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
