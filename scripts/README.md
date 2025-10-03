# Scripts

Build and validation scripts for OpenGardenLab.

## Overview

This directory contains utility scripts for:
- Compiling plant YAML files to JSON
- Validating plant database schema compliance
- CI/CD automation helpers

## Scripts

### `compile-plants.py`

Compiles YAML plant profiles to JSON for mobile app bundling.

**Usage:**
```bash
python scripts/compile-plants.py
```

**Output:** `mobile-app/app/src/main/assets/plants.json`

### `validate-plants.sh`

Validates all plant YAML files against JSON schema.

**Usage:**
```bash
bash scripts/validate-plants.sh
```

**Exit codes:**
- `0`: All plants valid
- `1`: Validation errors found

## Development

Implementation starts in **Story 2.2** (Plant Database Schema).
