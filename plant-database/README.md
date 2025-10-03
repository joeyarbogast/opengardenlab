# Plant Database

YAML-based plant profiles for OpenGardenLab.

## Overview

This directory contains human-editable plant profiles in YAML format, including:
- Optimal soil moisture ranges
- Light requirements (full sun, partial shade, etc.)
- Temperature and humidity preferences
- Citations to authoritative gardening sources

Plant data is compiled to JSON and bundled with the Android mobile app.

## Structure

```
plant-database/
├── schema/              # JSON schema for plant profiles
├── vegetables/          # Vegetable plant profiles (tomato.yaml, etc.)
├── herbs/               # Herb plant profiles (basil.yaml, etc.)
├── fruits/              # Fruit plant profiles (strawberry.yaml, etc.)
└── README.md            # This file
```

## Plant Profile Format

Each plant is defined in YAML with this structure:

```yaml
name: Tomato
scientific_name: Solanum lycopersicum
category: vegetable
soil_moisture:
  min: 60
  max: 80
  unit: percent
light:
  type: full_sun
  hours_per_day: 6-8
temperature:
  min: 65
  max: 85
  unit: fahrenheit
humidity:
  min: 50
  max: 70
  unit: percent
citations:
  - "University of California Agriculture & Natural Resources"
  - "https://example.com/tomato-care"
```

## Adding New Plants

1. Create a new YAML file in the appropriate category folder
2. Follow the schema defined in `schema/plant-profile.schema.json`
3. Run validation: `scripts/validate-plants.sh`
4. Compile to JSON: `scripts/compile-plants.py`

## Development

Implementation starts in **Story 2.2** (schema) and **Story 2.3** (plant profiles).
