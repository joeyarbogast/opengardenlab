# Data Models

## Core Entities

OpenGardenLab has 4 primary data entities shared between firmware and mobile app:

### 1. SensorReading

**Purpose:** Timestamped snapshot of all sensor values from a single sampling cycle.

**Storage:** SQLite table in both firmware and mobile app (schema mirrored for sync)

**Attributes:**

| Attribute | Type | Description |
|-----------|------|-------------|
| `id` | INTEGER (PK) | Auto-increment primary key |
| `device_id` | TEXT | Device identifier (Pi MAC address or UUID) |
| `timestamp` | TEXT (ISO 8601) | Reading time (UTC): `2025-10-02T14:30:00Z` |
| `soil_moisture` | REAL | Calibrated soil moisture (0-100%) |
| `soil_temp_stemma` | REAL | Soil temperature from STEMMA sensor (°C) |
| `soil_temp_ds18b20` | REAL (nullable) | Soil temperature from DS18B20 probe (°C), if present |
| `light_lux` | REAL | Light intensity (0-65535 lux) |
| `air_temp` | REAL | Air temperature from DHT20 (°C) |
| `air_humidity` | REAL | Relative humidity from DHT20 (0-100%) |

**TypeScript/Kotlin Interface (for mobile app):**

```typescript
interface SensorReading {
  id: number;
  deviceId: string;
  timestamp: string; // ISO 8601
  soilMoisture: number;
  soilTempStemma: number;
  soilTempDs18b20: number | null;
  lightLux: number;
  airTemp: number;
  airHumidity: number;
}
```

**Relationships:**
- Belongs to one `Device`
- Foreign key: `device_id` → `devices.id`

---

### 2. Plant

**Purpose:** Plant care profile with optimal environmental ranges.

**Storage:** YAML source files in `plant-database/`, compiled to JSON, bundled with mobile app

**Attributes:**

| Attribute | Type | Description |
|-----------|------|-------------|
| `id` | TEXT | Unique plant identifier (e.g., `tomato-cherry`) |
| `commonName` | TEXT | Display name (e.g., `Cherry Tomato`) |
| `scientificName` | TEXT | Botanical name (e.g., `Solanum lycopersicum var. cerasiforme`) |
| `category` | ENUM | `vegetable`, `herb`, or `fruit` |
| `soilMoisture` | Object | `{ min: number, max: number, notes: string }` |
| `light` | Object | `{ hoursPerDay: number, minLux: number, idealLux: number, notes: string }` |
| `airTemp` | Object | `{ minC: number, maxC: number, idealC: number, notes: string }` |
| `humidity` | Object (optional) | `{ min: number, max: number, notes: string }` |
| `sources` | Array | `[{ name: string, url: string }]` - Citations for data |

**TypeScript Interface:**

```typescript
interface Plant {
  id: string;
  commonName: string;
  scientificName: string;
  category: 'vegetable' | 'herb' | 'fruit';
  soilMoisture: {
    min: number;
    max: number;
    notes: string;
  };
  light: {
    hoursPerDay: number;
    minLux: number;
    idealLux: number;
    notes: string;
  };
  airTemp: {
    minC: number;
    maxC: number;
    idealC: number;
    notes: string;
  };
  humidity?: {
    min: number;
    max: number;
    notes: string;
  };
  sources: Array<{
    name: string;
    url: string;
  }>;
}
```

**Relationships:**
- Referenced by `Device.assignedPlantId`

---

### 3. Device

**Purpose:** Represents a physical OpenGardenLab device (Raspberry Pi + sensors) that user has paired.

**Storage:** SQLite table in mobile app only (firmware doesn't track this concept)

**Attributes:**

| Attribute | Type | Description |
|-----------|------|-------------|
| `id` | TEXT (PK) | Device unique ID (Bluetooth MAC address or Pi UUID) |
| `name` | TEXT | User-assigned label (e.g., `Tomato Bed`, `Herb Garden`) |
| `assignedPlantId` | TEXT (FK, nullable) | ID of assigned `Plant` from database |
| `lastSynced` | TEXT (ISO 8601, nullable) | Timestamp of last Bluetooth sync |
| `samplingIntervalMinutes` | INTEGER | Device sampling interval (15, 30, or 60) |
| `soilMoistureCalibration` | Object | `{ airValue: number, waterValue: number }` - Calibration values |

**TypeScript Interface:**

```typescript
interface Device {
  id: string;
  name: string;
  assignedPlantId: string | null;
  lastSynced: string | null;
  samplingIntervalMinutes: number;
  soilMoistureCalibration: {
    airValue: number;
    waterValue: number;
  };
}
```

**Relationships:**
- Has many `SensorReading` (one-to-many)
- Has one assigned `Plant` (via `assignedPlantId`)
- Has many `JournalEntry` (one-to-many)

---

### 4. JournalEntry

**Purpose:** User notes and auto-generated log entries for garden observations.

**Storage:** SQLite table in mobile app only

**Attributes:**

| Attribute | Type | Description |
|-----------|------|-------------|
| `id` | INTEGER (PK) | Auto-increment primary key |
| `deviceId` | TEXT (FK) | Associated device |
| `timestamp` | TEXT (ISO 8601) | Entry creation time |
| `entryType` | ENUM | `user_note`, `system_event` (e.g., "Device synced", "Plant assigned") |
| `content` | TEXT | Note text or event description |

**TypeScript Interface:**

```typescript
interface JournalEntry {
  id: number;
  deviceId: string;
  timestamp: string;
  entryType: 'user_note' | 'system_event';
  content: string;
}
```

**Relationships:**
- Belongs to one `Device` (via `deviceId`)

---

## Entity Relationship Diagram

```
┌─────────────────┐
│     Device      │
│─────────────────│
│ id (PK)         │◄──────┐
│ name            │       │
│ assignedPlantId │───┐   │
│ lastSynced      │   │   │
└─────────────────┘   │   │
        │             │   │
        │ 1:N         │   │
        ▼             │   │
┌─────────────────┐   │   │
│ SensorReading   │   │   │
│─────────────────│   │   │
│ id (PK)         │   │   │
│ deviceId (FK)   │───┘   │
│ timestamp       │       │
│ soilMoisture    │       │
│ lightLux        │       │
│ airTemp         │       │
│ ...             │       │
└─────────────────┘       │
                          │
        │ 1:N             │
        ▼                 │
┌─────────────────┐       │
│  JournalEntry   │       │
│─────────────────│       │
│ id (PK)         │       │
│ deviceId (FK)   │───────┘
│ timestamp       │
│ content         │
└─────────────────┘

                ┌──────────┐
                │  Plant   │
                │──────────│
                │ id (PK)  │◄──(referenced)
                │ name     │
                │ ranges   │
                └──────────┘
```

---

**Phase 2 Complete.** This section defined the complete tech stack (Kotlin for Android), repository structure (monorepo), and all core data models with relationships.

---
