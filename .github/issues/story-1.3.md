## Story 1.3: I2C and 1-Wire Interface Configuration

**Story File:** `docs/stories/1.3.i2c-1wire-interface-config.md`

**As a** developer,
**I want** I2C and 1-Wire interfaces enabled on Raspberry Pi,
**so that** I can communicate with digital sensors (STEMMA Soil, BH1750, DHT20, DS18B20).

### Acceptance Criteria
1. I2C interface enabled via `raspi-config` → Interface Options → I2C
2. 1-Wire interface enabled via `raspi-config` → Interface Options → 1-Wire
3. I2C tools installed (`sudo apt install i2c-tools`)
4. I2C bus scanned successfully (`i2cdetect -y 1`) - even without sensors connected yet, command runs without error
5. 1-Wire device tree overlay loaded (verified in `/boot/config.txt` or `/boot/firmware/config.txt`)

### Labels
- `epic-1`
- `story`
