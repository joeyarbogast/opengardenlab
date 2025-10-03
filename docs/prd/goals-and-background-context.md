# Goals and Background Context

## Goals

- Build a working IoT garden monitoring system that successfully captures and syncs sensor data (moisture, light, temperature) for real-world garden conditions
- Create actionable plant recommendations based on sensor readings compared to optimal ranges, helping diagnose and prevent plant problems
- Develop practical skills in hardware integration, Python firmware development, Android mobile app development, and IoT architecture
- Establish a solid foundation that supports future expansion with diagnostic features, additional sensors, and multi-device architecture
- Share the project openly as an open-source tool that other home gardeners can build and benefit from

## Background Context

Home gardeners face a frustrating problem: when plants show symptoms like yellowing leaves or wilting, online searches return 10+ possible causes without clear guidance on identifying the actual root cause. This leads to trial-and-error remediation, wasted time, preventable plant loss, and analysis paralysis from information overload.

Existing commercial garden monitors are expensive ($200+), require cloud subscriptions, are closed-source, and focus on automation rather than helping gardeners understand and diagnose problems. Plant care apps provide generic advice without real sensor data from YOUR specific garden conditions.

OpenGardenLab addresses this gap by combining affordable IoT sensor hardware with a local-first mobile app that provides data-driven plant care recommendations. The MVP focuses on continuous monitoring of core environmental factors (soil moisture, light intensity, temperature) and comparing actual conditions against optimal ranges for specific plant types. This provides gardeners with concrete, actionable insights: "Your tomatoes are receiving only 4 hours of sun daily but need 6-8 hours" or "Soil moisture has been below 30% for 5 days; tomatoes prefer 40-60%."

Unlike commercial solutions, OpenGardenLab is:
- **Open source** - complete transparency, no vendor lock-in
- **Local-first** - no cloud dependency, no subscriptions, complete data ownership
- **Learning-focused** - designed as a personal learning project in IoT/mobile development while solving a real problem
- **Modular & expandable** - start with MVP sensors, expand with diagnostics, advanced sensors, and multi-device support in future phases

This project builds on extensive Phase 1 research validating technical feasibility:
- **Hardware platform selected:** Raspberry Pi Zero 2 W with Python (faster development, superior debugging vs ESP32/C++)
- **Sensors identified:** All I2C digital sensors (STEMMA Soil, BH1750 light, DHT20 temp/humidity) - no ADC needed
- **Plant database strategy:** Manual curation from university extension guides (50-75 plants for MVP)
- **Budget validated:** $99-150 per device (well under $300 target)
- **Timeline validated:** 4-6 months part-time is realistic for solo developer

**Phase 1 research complete.** This PRD translates that research into specific product requirements for MVP development.

---
