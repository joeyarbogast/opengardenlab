# Introduction

This document defines the complete system architecture for **OpenGardenLab**, an IoT garden monitoring system that combines hardware sensors, embedded firmware, and a mobile application to help home gardeners make data-driven decisions about plant care.

Unlike traditional web application architectures, OpenGardenLab is a **hardware/software hybrid system** with unique architectural considerations:

- **Embedded hardware** running autonomously in outdoor environments
- **Local-first data architecture** with no cloud dependency
- **Bluetooth Low Energy** communication instead of HTTP/REST
- **Power management** for battery-operated devices
- **Environmental durability** (weatherproofing, temperature extremes)

This architecture is informed by:
- [Project Brief](project-brief.md) - Initial vision and goals
- [PRD](prd.md) - 30 user stories across 4 epics
- [Technical Feasibility Research](technical-feasibility.md) - Hardware platform selection
- [Sensor Selection Research](sensor-selection.md) - I2C sensor specifications
- [Plant Database Research](plant-database-research.md) - Data curation strategy

## Architecture Type

**Greenfield IoT System** - No existing codebase or starter templates. Custom-designed for educational IoT development with open-source distribution.

---
