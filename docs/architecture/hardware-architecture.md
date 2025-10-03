# Hardware Architecture

## Component Overview

The OpenGardenLab device consists of:

**Compute Platform:**
- **Raspberry Pi Zero 2 W** - BCM2710A1 SoC (4× ARM Cortex-A53 @ 1GHz), 512MB RAM
- **MicroSD Card** - 16-32GB (high-endurance class for frequent writes)
- **Operating System** - Raspberry Pi OS Lite 64-bit (Debian-based, headless)

**Sensors (all I2C or 1-Wire digital):**
- **Adafruit STEMMA Soil Sensor (4026)** - I2C capacitive moisture + soil temp
- **Adafruit BH1750 (4681)** - I2C light sensor (1-65,535 lux)
- **Adafruit DHT20/AHT20 (5183)** - I2C air temp + humidity
- **DS18B20 Waterproof Probe** - 1-Wire soil temperature (optional, more accurate than STEMMA)

**Power:**
- **2× USB Power Banks** (10,000-20,000mAh) - Swappable weekly (charge one while using one)
- **USB-to-MicroUSB cable** for Pi power

**Enclosure:**
- **IP65 waterproof box** (12-20cm) with clear acrylic window for light sensor
- **Cable glands** for sensor wires exiting enclosure

**Connectivity:**
- **WiFi 802.11n** (2.4GHz) - Used only for SSH development access, disabled in production
- **Bluetooth 4.2 BLE** - Primary communication with mobile app

---

## Sensor Wiring Diagram

All sensors connect to Raspberry Pi GPIO header via **I2C bus (SDA, SCL) and 1-Wire (GPIO4)**:

```
Raspberry Pi Zero 2 W GPIO Header
┌─────────────────────────────────┐
│  Pin 1 (3.3V) ────┬──────┬──────┼─── All sensor VCC
│  Pin 3 (SDA)  ────┼──┬───┼──────┼─── I2C Data (STEMMA, BH1750, DHT20)
│  Pin 5 (SCL)  ────┼──┼───┼──────┼─── I2C Clock (STEMMA, BH1750, DHT20)
│  Pin 6 (GND)  ────┴──┴───┴──────┼─── All sensor GND
│  Pin 7 (GPIO4) ───────────────────── DS18B20 Data (1-Wire) + 4.7kΩ pullup to 3.3V
└─────────────────────────────────┘

Sensors:
1. Adafruit STEMMA Soil (I2C 0x36): VCC, GND, SDA, SCL
2. Adafruit BH1750 Light (I2C 0x23): VCC, GND, SDA, SCL
3. Adafruit DHT20 (I2C 0x38): VCC, GND, SDA, SCL
4. DS18B20 Soil Temp (1-Wire): VCC, GND, Data (GPIO4), 4.7kΩ pullup
```

**Advantages of all-digital sensor architecture:**
- No ADC required (simplifies wiring, reduces component count)
- All I2C sensors share 2 wires (SDA, SCL) - easy to add more sensors
- Digital readings are more accurate and stable than analog
- Well-supported Python libraries (Adafruit CircuitPython)

**I2C Address Map:**
- `0x36` - STEMMA Soil Sensor
- `0x23` - BH1750 Light Sensor
- `0x38` - DHT20 Temp/Humidity Sensor

No address conflicts. If additional I2C sensors are added post-MVP, addresses can be checked with `i2cdetect -y 1`.

---

## Physical Deployment Architecture

**Enclosure Design:**

```
┌─────────────────────────────────────┐
│  IP65 Waterproof Enclosure          │
│                                     │
│  ┌────────────┐    ┌─────────────┐ │
│  │ Raspberry  │    │  USB Power  │ │
│  │ Pi Zero 2W │◄───┤  Bank       │ │
│  │            │    │ 20,000mAh   │ │
│  └────────────┘    └─────────────┘ │
│                                     │
│  [Clear Acrylic Window]             │  ← BH1750 light sensor inside
│     (for light sensor)              │
│                                     │
│  Cable Glands ↓↓↓                   │
└──────────────│││────────────────────┘
               │││
      ┌────────┘││
      │   ┌─────┘│
      │   │   ┌──┘
      ▼   ▼   ▼
   [Soil] [Soil] [Air]
   Moisture Temp  Temp/Humid
   (STEMMA)(DS18B20)(DHT20)
```

**Sensor Placement Best Practices:**

1. **Soil Moisture Sensor (STEMMA):**
   - Depth: 2-4 inches (5-10cm) in root zone
   - Location: Midway between plant stem and edge of root zone
   - Installation: Insert at 45° angle, full probe depth in soil

2. **Light Sensor (BH1750):**
   - Location: Inside enclosure behind clear acrylic window
   - Height: 6-12 inches above soil (or at plant canopy height)
   - Orientation: Window facing upward (measures ambient light)

3. **Air Temp/Humidity (DHT20):**
   - Location: Inside enclosure (ventilated, shaded)
   - Height: 4-6 inches above soil
   - Note: Enclosure must allow airflow (vent holes with mesh to keep bugs out)

4. **Soil Temp Probe (DS18B20):**
   - Depth: 2-4 inches (same depth as moisture sensor)
   - Location: Near moisture sensor for correlated readings
   - Installation: Insert probe horizontally into soil (long cable allows enclosure to be above ground)

**Power Management:**
- Pi Zero 2 W consumes ~100-150mA idle, ~400mA peak (sensor reads + Bluetooth)
- 20,000mAh power bank = ~133 hours = 5.5 days at 150mA average
- **Target: 7+ days** requires optimizations (disable WiFi, reduce sampling frequency)
- User swaps power bank weekly, charges drained one

---

## Bill of Materials (BOM)

| **Component** | **Model/Specs** | **Qty** | **Unit Cost** | **Total** |
|---------------|-----------------|---------|---------------|-----------|
| Raspberry Pi Zero 2 W | BCM2710A1, 512MB RAM | 1 | $18 | $18 |
| MicroSD Card | 16-32GB high-endurance | 1 | $10 | $10 |
| STEMMA Soil Sensor | Adafruit 4026 | 1 | $7 | $7 |
| BH1750 Light Sensor | Adafruit 4681 | 1 | $6 | $6 |
| DHT20 Temp/Humidity | Adafruit 5183 | 1 | $6 | $6 |
| DS18B20 Soil Temp Probe | Waterproof | 1 | $10 | $10 |
| USB Power Banks (2×) | 10,000-20,000mAh | 2 | $20 | $40 |
| IP65 Enclosure | 12-20cm waterproof box | 1 | $15 | $15 |
| STEMMA QT Cables | I2C interconnect | 2 | $2 | $4 |
| 4.7kΩ Resistor | Pullup for 1-Wire | 1 | $0.10 | $0.10 |
| Misc | Jumper wires, USB cables | - | $5 | $5 |
| **TOTAL PER DEVICE** | | | | **$121** |

**Within budget:** PRD target was $150/device. Actual ~$121 leaves $29 margin for enclosure upgrades or additional sensors.

---

**Phase 1 Complete.** This section established the foundation: introduction, platform choice, and complete hardware architecture with wiring, deployment, and BOM.

---
