# Project Brief: OpenGardenLab

**Project Name:** OpenGardenLab
**Date:** 2025-10-01
**Author:** Business Analyst (Mary)
**Status:** Final

---

## Executive Summary

**OpenGardenLab** is an open-source IoT garden monitoring and diagnostic system that helps home gardeners prevent and diagnose plant problems through sensor-based data collection and actionable guidance. The system combines a local-first hardware device (IoT sensors) with a mobile application to monitor critical garden conditions (light, moisture, temperature, soil nutrients) and provide step-by-step remediation plans when issues arise.

Targeting both beginner and experienced home gardeners, OpenGardenLab addresses the frustration of diagnosing plant problems (e.g., yellowing leaves) where online searches yield 10+ possible causes without clear guidance. The solution differentiates itself through its open-source nature, local-first architecture (no cloud dependency), modular expandable hardware, and community-driven plant knowledge database.

---

## Problem Statement

### Current State and Pain Points

Home gardeners face significant challenges diagnosing and preventing plant health issues. When problems arise—such as yellowing leaves, wilting, or poor growth—gardeners typically turn to online searches that yield 10+ possible causes without clear guidance on determining the actual root cause. This leads to:

- **Trial-and-error remediation** that wastes time and may worsen the problem
- **Analysis paralysis** from information overload without actionable steps
- **Preventable plant loss** due to delayed or incorrect interventions
- **Lack of data** about actual garden conditions (light hours, moisture patterns, soil chemistry)

**Similar challenges exist with composting**, where gardeners struggle to maintain optimal conditions (temperature, moisture, carbon/nitrogen balance) without clear indicators of what's working or what needs adjustment.

Experienced gardeners rely on intuition built over years, but beginners lack this knowledge. Even experienced gardeners struggle with new plants, microclimate variations, or subtle issues that develop slowly over time.

### Impact of the Problem

- **Financial loss** from dead plants and wasted amendments/treatments
- **Frustration and discouragement** especially for beginners
- **Suboptimal harvests** from undiagnosed nutrient deficiencies or environmental stress
- **Missed opportunities** to prevent problems before symptoms appear

### Why Existing Solutions Fall Short

Current solutions are fragmented and incomplete:

- **Commercial garden monitors** are expensive, cloud-dependent (subscription fees), closed-source, and focus on automation rather than diagnosis
- **Plant care apps** provide generic advice without real sensor data from YOUR garden
- **Manual monitoring** is time-intensive and relies on human observation (can't track trends 24/7)
- **Online forums** offer anecdotal advice without data-driven validation

### Urgency and Importance

With growing interest in home gardening, food security, and sustainability, there's increasing demand for tools that help gardeners succeed. An open-source, local-first, affordable solution that combines sensor monitoring with diagnostic guidance fills a critical gap in the market while building a community-driven knowledge base.

---

## Proposed Solution

### Core Concept and Approach

**OpenGardenLab** is an open-source, local-first IoT monitoring system that combines:

1. **Hardware Device(s)** - Microcontroller-based sensor platform (Raspberry Pi, ESP32, or Arduino-based) with modular, expandable sensors for:
   - Light intensity and duration
   - Soil moisture levels
   - Temperature (air and soil)
   - Soil chemistry (NPK, pH) via custom or commercial sensors
   - Optional (future): Camera module for photo-based pest/fungal identification

2. **Mobile Application** - Primary interface for:
   - **Device configuration** (sensor setup, calibration, sync settings, mode selection)
   - **Garden planning tool** (visual layout of beds, companion planting guidance, plant placement recommendations)
   - Data visualization and trend analysis
   - Plant knowledge database (optimal ranges per plant type)
   - Decision tree diagnostics (interactive troubleshooting)
   - Multi-theory testing with feedback loops
   - Garden journal and notes
   - Multi-device management (label and track multiple garden zones)

3. **Local-First Architecture** - All data stored and processed locally:
   - Device stores data, syncs via Bluetooth to mobile app
   - No cloud dependency, no subscriptions
   - Privacy-focused, works offline

4. **Multi-Mode Support** - Device can operate in different modes:
   - Garden Mode (plant monitoring)
   - Compost Mode (decomposition monitoring)
   - Indoor Plant Mode (houseplant care)

### Key Differentiators

- **Open Source** - Hardware designs, firmware, and mobile app all open-source
- **Community-Driven Knowledge** - Plant database and decision trees contributed/improved by experienced gardeners
- **Local-First** - No cloud, no subscriptions, complete data ownership
- **Modular & Expandable** - Start with basic sensors, add more over time
- **Multi-Device Architecture** - Support multiple garden zones/beds (architecture TBD)
- **Diagnostic Focus** - Not just monitoring, but actionable guidance on problem diagnosis
- **Maker-Friendly** - Designed for DIY assembly with comprehensive guides

### Why This Solution Will Succeed

**OpenGardenLab** addresses the core problem (data-driven diagnosis) while avoiding the pitfalls of commercial solutions (cost, cloud dependency, closed ecosystem). By building an engaged open-source community, the plant knowledge base will grow richer over time, and the modular architecture allows both beginners (start simple) and tinkerers (customize extensively) to benefit.

### High-Level Vision

A thriving ecosystem where:
- Gardeners worldwide contribute plant profiles, decision trees, and sensor designs
- The system learns from successful interventions and shares anonymized patterns
- Custom sensors and hardware extensions are created by the maker community
- Local gardener networks share region-specific insights while maintaining privacy

---

## Target Users

### Primary User Segment: Home Gardeners (Beginner to Intermediate)

**Profile:**
- Age range: 25-65
- Mix of beginners (first-time gardeners) and intermediate gardeners (2-5 years experience)
- Growing vegetables, herbs, and flowers in backyard gardens, raised beds, or containers
- Tech-comfortable but not necessarily technical (can follow setup guides)
- Mix of suburban homeowners and urban apartment dwellers with outdoor space

**Current Behaviors:**
- Googling plant problems when symptoms appear
- Following generic watering schedules or intuition
- Buying amendments/fertilizers reactively when problems occur
- Posting photos to gardening forums asking "What's wrong with my plant?"

**Specific Needs:**
- **Simple, actionable guidance** - "Water 1 cup twice daily" not just "water regularly"
- **Confidence-building** - Clear explanations of what's happening and why
- **Problem prevention** - Know before plants show symptoms
- **Honest assessment** - "Your balcony doesn't get enough sun for peppers, try lettuce instead"

**Goals:**
- Keep plants alive and productive
- Learn gardening skills over time
- Reduce plant loss and wasted money
- Harvest fresh vegetables and herbs

---

### Secondary User Segment: Experienced Gardeners & Maker/Tinkerers

**Profile:**
- **Experienced Gardeners:** 10+ years of gardening, grow 15-20+ varieties per season
- **Makers/Tinkerers:** Software developers, electronics hobbyists interested in IoT/gardening intersection
- Comfortable with technology and DIY projects
- Willing to assemble hardware and troubleshoot issues

**Current Behaviors:**
- Rely on intuition and experience for plant care
- Manually track conditions in notebooks or spreadsheets
- Research specific problems in depth when they arise
- Experiment with growing techniques and new varieties

**Specific Needs:**
- **Transparent, data-driven insights** - Show the sensor data and reasoning
- **Validation of intuition** - Confirm or challenge gut feelings with data
- **Extensibility** - Add custom sensors, modify firmware, contribute improvements
- **Community contribution** - Share expertise and improve the knowledge base
- **Advanced features** - Granular data access, historical trends, multi-season analysis

**Goals:**
- Optimize garden performance
- Validate and refine gardening techniques with data
- Contribute to opensource community
- Build and customize their monitoring system
- Create custom sensors or integrations

---

### Tertiary User Segment: Urban/Constrained Space Gardeners

**Profile:**
- Apartment dwellers with balconies, patios, or small outdoor spaces
- Limited to container gardening (3-6 containers/small raised beds)
- Often face environmental constraints (building shadows, wind, limited sun exposure)
- Hand-watering only (no irrigation system access)
- Growing herbs, small vegetables (peppers, tomatoes), or ornamental plants

**Current Behaviors:**
- Trial-and-error to find what grows in their specific conditions
- Frustrated by conflicting online advice that assumes ideal conditions
- Hand-water daily or on schedule
- Often limited by uncontrollable factors (sun exposure, wind)

**Specific Needs:**
- **Honest environmental assessment** - "Your space gets 3hrs sun, here's what will actually grow"
- **Container-specific guidance** - Different needs than in-ground gardens
- **Specific watering volumes** - "1 cup morning, 1 cup evening" for hand-watering
- **WiFi connectivity option** - Closer to router than ground-level gardens
- **Compact device** - Space-conscious design

**Goals:**
- Successfully grow plants despite environmental constraints
- Discover what actually works in their unique microclimate
- Maximize limited space productivity
- Avoid wasting money on plants that won't thrive

---

## Goals & Success Metrics

### Project Objectives

- **Personal Learning:** Successfully build and deploy a working IoT garden monitoring system
- **Problem Solving:** Create a tool that actually helps diagnose and prevent plant problems in YOUR garden
- **Skill Development:** Learn hardware integration, mobile app development, and IoT architecture
- **Opensource Contribution:** Share the project publicly so others can benefit if interested
- **Extensibility:** Build a system that can grow and evolve with new sensors and features over time

### User Success Metrics (For Your Own Use)

- **Problem Resolution:** Successfully diagnose and resolve plant issues in your garden using sensor data
- **Data Quality:** Device reliably captures and syncs sensor data without constant troubleshooting
- **Usability:** Mobile app is intuitive enough that you actually use it (not just built it)
- **Actionable Insights:** System provides guidance that's actually helpful, not just data dumps
- **Preventive Value:** Catch problems before plants show severe symptoms

### Key Performance Indicators (Personal Benchmarks)

- **Device Reliability:** Device stays operational with minimal maintenance
- **Data Accuracy:** Sensor readings are consistent and trustworthy
- **Diagnostic Success Rate:** When you follow system recommendations, do they actually work?
- **Time Savings:** Reduce time spent googling plant problems and trial-and-error fixes
- **Feature Usefulness:** Which features do you actually use vs. which seemed good in theory?

### If Others Join (Bonus Objectives)

- Clear documentation so others can replicate your setup
- Community contributions improve the plant knowledge base
- Other makers extend the system with custom sensors/features

---

## MVP Scope

### Core Features (Must Have)

- **Hardware Device:**
  - Microcontroller-based device (hardware platform TBD: Raspberry Pi, ESP32, or Arduino)
  - Basic sensor support: Soil moisture + light intensity + temperature (air and/or soil)
  - Local data storage on device
  - Waterproof enclosure design
  - Solar power + battery backup capability
  - Assembly guide and bill of materials (BOM)

- **Bluetooth Sync:**
  - Bluetooth connectivity between device and mobile app
  - Data synchronization when in range
  - Scheduled sync reminders (daily notifications)
  - Sync status indicators

- **Mobile App - Data Visualization:**
  - View current sensor readings (moisture, light, temperature)
  - Historical data charts and trends (daily, weekly, monthly views)
  - Multi-device support (label and manage multiple garden zones/beds)
  - Device configuration (sensor calibration, sync settings, plant type selection)

- **Plant Knowledge Database:**
  - Comprehensive database of common vegetables/fruits/herbs grown by home gardeners
  - Each plant profile includes: optimal moisture range, optimal light hours/day, optimal temperature range
  - Research and compile data from authoritative gardening sources
  - User assigns plant type to each device/garden zone
  - Simple comparison: actual conditions vs. optimal ranges

- **Basic Recommendations:**
  - Alert when conditions fall outside optimal range for assigned plant
  - Simple guidance examples:
    - "Your tomato plant has averaged 25% soil moisture over the last 5 days. Tomatoes prefer 40-60% moisture. Consider watering more frequently."
    - "Your lettuce is receiving 8 hours of direct sun daily. Lettuce prefers 4-6 hours. Consider providing afternoon shade."
    - "Temperatures have been below 50°F for 3 nights. Your peppers prefer nighttime temps above 55°F. Consider frost protection."
  - Trend-based (requires multiple days of data, not single readings)

- **Multi-Device Management:**
  - Unique device IDs and user-defined labels ("Tomato Bed", "Herb Garden", etc.)
  - Switch between devices in app
  - Independent data tracking per device

- **Garden Journal:**
  - Note-taking feature for observations and actions taken
  - Date-stamped entries
  - Attach notes to specific devices/garden zones

### Out of Scope for MVP

- Soil chemistry sensors (NPK, pH) - most complex, deferred to post-MVP
- Diagnostic decision trees (interactive troubleshooting)
- Multi-theory testing workflows (try Plan A, report back, iterate)
- Community knowledge sharing / contribution framework
- Photo-based pest/fungal identification
- Growth stage tracking (planting date → nutrient needs over time)
- Compost Mode / Indoor Plant Mode (multi-mode support)
- WiFi or cellular connectivity
- Cloud sync or backup
- Automated watering/intervention
- Advanced analytics (year-over-year trends, predictive alerts, microclimate learning)
- Custom sensor plugin architecture (expandability mechanism deferred)
- Web interface
- Self-improving knowledge base (learning from successful interventions)

### MVP Success Criteria

The MVP will be considered successful when:

1. **Device functions reliably:** Captures moisture, light, and temperature data continuously for 2+ weeks without intervention
2. **Sync works consistently:** Bluetooth sync completes successfully 95%+ of attempts
3. **Data is useful:** Can observe meaningful patterns and receive actionable recommendations
4. **Recommendations are helpful:** At least one plant recommendation leads to a successful intervention
5. **Plant database is comprehensive:** Covers 50+ common garden vegetables, fruits, and herbs with accurate data
6. **Setup is achievable:** You can build and deploy the device following your own documentation
7. **You actually use it:** Check the app at least 3x per week to review garden data and recommendations
8. **Foundation is solid:** Architecture supports adding diagnostic features in v2 without major refactoring

---

## Post-MVP Vision

### Phase 2 Features

(Note: Phase 2 may need to be broken into smaller phases)

**Diagnostic Engine:**
- Interactive decision tree troubleshooting ("Are leaves yellow on top or bottom?")
- Multi-theory testing workflows (suggest 3 possible causes → user tries Plan A → report results → narrow diagnosis)
- Photo capture and analysis (manual comparison against symptom library)
- Growth stage tracking based on planting date and plant size

**Advanced Sensors:**
- Soil chemistry (NPK levels, pH)
- Custom sensor support and documentation
- Camera module for visual monitoring

**Enhanced Intelligence:**
- Historical pattern recognition (year-over-year trends)
- Predictive alerts ("moisture dropping faster than usual, check irrigation")
- Microclimate learning ("west bed always 5°F warmer in afternoon")

**Multi-Mode Device:**
- Compost Mode (temperature, moisture, turning reminders)
- Indoor Plant Mode (container-specific guidance)
- Mode switching via mobile app

### Long-Term Vision (1-2 Years)

**Community Ecosystem:**
- Plant knowledge contribution framework (experienced gardeners improve database)
- Decision tree contributions and validation
- Anonymous local knowledge sharing (nearby gardeners with similar issues/solutions)
- Regional pattern recognition

**Maker Extensibility:**
- Plugin architecture for custom sensors
- Firmware customization framework
- Community sensor marketplace (designs, not commercial products)
- API for third-party integrations

**Advanced Architecture:**
- Multi-device communication (mesh or hub+spoke, TBD)
- WiFi connectivity option (in addition to Bluetooth)
- Optional cloud backup for long-term historical data
- Cross-platform support (web interface)

**Autonomous Features:**
- Pest deterrence devices (ultrasonic, light-based)
- Optional irrigation integration (for users with systems)
- Automated environmental adjustments (if technically feasible)

### Expansion Opportunities

- **Greenhouse monitoring** - controlled environment optimization
- **Soil microbiome sensors** - beneficial bacteria and fungal composition (if technology becomes accessible)
- **Educational applications** - schools teaching plant science
- **Small-scale farming** - scaled-up version for market gardeners
- **Integration with other systems** - weather stations, home automation platforms
- **Localization** - plant databases for different regions/climates worldwide

---

## Technical Considerations

### Platform Requirements

- **Hardware Device:**
  - Target Platforms: Microcontroller-based (Raspberry Pi, ESP32, or Arduino) - **final decision TBD after research**
  - Must support: Bluetooth connectivity, local storage, multiple sensor inputs
  - Power: Solar + battery backup capability
  - Enclosure: Waterproof/weather-resistant for outdoor deployment
  - Cost target: Under $300 per device (Raspberry Pi ~$160 + sensors + enclosure + power)

- **Mobile Application:**
  - Target Platform: Android (native development)
  - Minimum OS Support: TBD based on Bluetooth requirements
  - Offline-first architecture (works without internet)

- **Performance Requirements:**
  - Sensor data capture: Every 15-60 minutes (configurable)
  - Bluetooth sync: Complete within 2-3 minutes
  - Mobile app: Responsive UI, charts render in < 2 seconds
  - Battery life: 7+ days without solar charging

### Technology Preferences

- **Hardware/Firmware:**
  - Microcontroller platform: **TBD** (need to evaluate Raspberry Pi vs. ESP32 vs. Arduino)
    - **Important consideration:** Language support varies by platform:
      - Raspberry Pi: Python ✅, Go ✅, Rust ✅, Java ✅, C/C++, .NET (via .NET IoT)
      - ESP32: C/C++, MicroPython ✅, Rust ✅ (via esp-rs project)
      - Arduino: Primarily C/C++
  - **Your background:** .NET and web development (8 years) - want to expand skills with new language
  - **Languages to evaluate:** Python, Go, Rust, Java, C/C++
  - **Evaluation criteria:**
    - Learning curve from .NET background
    - IoT/hardware library ecosystem
    - Sensor compatibility and community support
    - Performance requirements
    - Long-term maintainability
  - **Decision needed:** Research and compare languages + platforms together (Architect deliverable)

- **Mobile App:**
  - **Platform:** Android-first (you own Android device for testing)
  - **Framework/Language:** **TBD** (need to evaluate options)
    - **Options to evaluate:**
      - Native Android (Kotlin or Java)
      - Cross-platform (React Native, Flutter, .NET MAUI)
    - **Evaluation criteria:**
      - Learning curve from .NET/web background
      - Full Bluetooth API access
      - Local database support
      - Charting/visualization libraries
      - Long-term maintainability
      - Potential for iOS support later
  - **Decision needed:** Research and compare mobile frameworks (Architect deliverable)
  - Local database: TBD based on framework choice (Room, SQLite, Realm, etc.)
  - Charts/visualization: TBD based on framework choice
  - Bluetooth: Must support Bluetooth Low Energy (BLE) APIs

- **Plant Knowledge Database:**
  - Format: Structured data (JSON, YAML, or SQLite)
  - Storage: Bundled with mobile app (local-first)
  - Schema: Plant profiles with optimal ranges (moisture %, light hrs/day, temp ranges)

### Architecture Considerations

- **Repository Structure:**
  - Monorepo vs. separate repos for firmware, mobile app, documentation (TBD)
  - Clear separation of concerns (hardware, firmware, mobile app, plant database)

- **Data Architecture:**
  - Local-first: All data stored on device and mobile app
  - No cloud dependency for MVP
  - Data sync protocol: Simple JSON over Bluetooth

- **Multi-Device Support:**
  - Architecture TBD: Options include hub+spoke, mesh network, or star topology
  - Each device has unique ID
  - Mobile app manages multiple device connections

- **Sensor Modularity:**
  - MVP: Hardcoded support for moisture, light, temperature sensors
  - Post-MVP: Plugin architecture for extensibility

- **Security/Compliance:**
  - Local-first = minimal security concerns (no external data transmission)
  - Bluetooth pairing security (standard BT protocols)
  - No PII collected or stored
  - Opensource license: **TBD** (MIT, Apache, GPL options to evaluate)

### Integration Requirements

- **Sensor Integration:**
  - Support common moisture sensors (capacitive preferred over resistive)
  - Support light sensors (LUX measurement or photodiode)
  - Support temperature sensors (DS18B20, DHT22, or similar)

- **Future Integrations (Post-MVP):**
  - Optional WiFi connectivity
  - Optional cloud backup services
  - Weather API integration for correlation
  - Home automation platforms (Home Assistant, etc.)

---

## Constraints & Assumptions

### Constraints

- **Budget:**
  - Personal project with no external funding
  - Hardware cost per device should be reasonable for personal/hobbyist use
  - Budget target: Under $300 per device (not thousands), lower is better
  - Raspberry Pi alone: ~$160, plus sensors, enclosure, power supply, etc.
  - No budget for cloud services or subscriptions

- **Timeline:**
  - Very flexible - personal learning project with no fixed deadline
  - MVP completion driven by learning pace and available personal time
  - Development will be part-time (evenings/weekends)

- **Resources:**
  - Solo developer (you) + Claude Code for assistance
  - Opensource community contributions are future possibility, not initial expectation
  - Learning curve expected for new technologies (Kotlin, Python/Go/Rust, IoT hardware)

- **Technical:**
  - **Local-first architecture required** - no cloud dependency, no subscriptions
  - Must work offline (no internet required after initial setup)
  - Android device for testing (no iOS device available for MVP)
  - Limited to consumer-grade sensors (no expensive lab equipment)
  - Bluetooth range limitations (typically 30-100 feet)
  - Battery/solar power constraints for outdoor deployment

### Key Assumptions

- Common garden sensors (moisture, light, temperature) are affordable and reliable enough for home use
- Bluetooth connectivity is sufficient for initial sync requirements
- Plant knowledge database can be researched and compiled from publicly available gardening resources
- DIY assembly is acceptable for target users (maker/tinkerer mindset)
- Basic sensor data (moisture, light, temp) provides sufficient value before adding complex diagnostics
- Python/Go/Rust have adequate IoT libraries for chosen hardware platform
- Kotlin/Android native development is viable for building the mobile app
- Multi-device architecture can be designed without needing all devices simultaneously for testing
- Opensource licensing will not create legal/IP complications
- Simple range-based recommendations (actual vs. optimal) are useful without complex ML/AI

---

## Risks & Open Questions

### Key Risks

- **Hardware Platform Selection:** Choosing the wrong microcontroller platform could limit language options, sensor compatibility, or inflate costs. Mitigation: Thorough research phase comparing Raspberry Pi, ESP32, Arduino options.

- **Sensor Reliability:** Consumer-grade sensors may be inaccurate, drift over time, or fail in outdoor conditions. Mitigation: Research sensor reviews, plan for calibration features, consider sensor redundancy.

- **Learning Curve:** Learning 2-3 new technologies simultaneously (Kotlin + Python/Go/Rust + IoT hardware) could slow progress significantly. Mitigation: Flexible timeline, start with simpler proof-of-concept, leverage Claude Code for guidance.

- **Bluetooth Limitations:** Range and reliability of Bluetooth may be insufficient for garden distances or through walls. Mitigation: Test early, consider WiFi as backup option in architecture design.

- **Battery/Solar Power:** Device may not stay powered in low-sun conditions (winter, shaded areas, rainy weeks). Mitigation: Design for low power consumption, battery capacity planning, test in real conditions.

- **Plant Database Accuracy:** Incorrect optimal ranges in plant database could lead to bad recommendations. Mitigation: Use authoritative sources, validate with experienced gardeners, allow user customization.

- **Multi-Device Complexity:** Managing multiple devices may introduce architectural complexity too early. Mitigation: Design for multi-device but test with single device initially.

- **Scope Creep:** Easy to over-engineer or add features beyond MVP. Mitigation: Strict adherence to MVP scope, defer all "nice-to-haves" to Phase 2.

### Open Questions

- Which microcontroller platform best balances cost, language support, and sensor compatibility?
- Which firmware language (Python, Go, Rust, Java, C/C++) is best for the chosen platform given learning goals?
- What specific sensor models should be used for moisture, light, and temperature?
- How often should sensors capture data? (Every 5 min? 15 min? 60 min?)
- What battery capacity and solar panel size are needed for 24/7 operation?
- Where can we source reliable plant knowledge data? (USDA, university extension offices, gardening databases?)
- What Bluetooth protocol should be used? (Classic vs. BLE?)
- How much local storage is needed on the device? (Days? Weeks? Months of data?)
- What's the best opensource license for this project? (MIT, Apache 2.0, GPL?)
- Should the device have any physical UI (LEDs, buttons) or be purely mobile-app controlled?

### Areas Needing Further Research

- **Hardware Platform Comparison:** Formal evaluation of Raspberry Pi vs. ESP32 vs. Arduino (cost, language support, GPIO pins, power consumption, sensor libraries)
- **Language Selection:** Comparative analysis of Python, Go, Rust for chosen hardware platform
- **Sensor Selection:** Research and select specific moisture, light, and temperature sensors (models, vendors, accuracy, longevity)
- **Power System Design:** Calculate power requirements, battery sizing, solar panel specifications
- **Plant Database Sources:** Identify authoritative data sources for plant optimal ranges (50+ common vegetables/fruits/herbs)
- **Bluetooth Architecture:** Design data sync protocol, message format, connection management
- **Enclosure Design:** Waterproof options, ventilation needs, mounting strategies
- **Data Schema:** Design database schema for sensor readings, plant profiles, device metadata
- **Multi-Device Architecture:** Evaluate hub+spoke vs. mesh vs. star topology trade-offs

---

## Appendices

### A. Research Summary

This Project Brief builds on an extensive brainstorming session conducted on 2025-10-01. Key findings:

**Brainstorming Session Results** (see [docs/brainstorming-session-results.md](docs/brainstorming-session-results.md)):
- 4 brainstorming techniques applied: What If Scenarios, First Principles Thinking, SCAMPER, Role Playing
- 75+ ideas generated across features, architecture, and user needs
- 4 user personas developed: Beginner Gardener (Sarah), Experienced Gardener (Bob), Urban Gardener (Maria), Tinkerer (Alex)
- Key insights:
  - MVP should focus on data collection + basic recommendations (not full diagnostics)
  - Local-first architecture is differentiator and requirement
  - Multi-device support is critical for multiple garden zones
  - Plant knowledge database + decision trees preferred over AI/ML complexity
  - Community contributions are bonus, not initial requirement

**Project Naming Research:**
- Evaluated 30+ potential names for availability
- Selected: **OpenGardenLab**
- Rationale: Signals opensource nature, scientific/data-driven approach, avoids hardware lock-in, no naming conflicts found

### B. References

**Brainstorming Documentation:**
- [docs/brainstorming-session-results.md](docs/brainstorming-session-results.md) - Complete brainstorming session output with categorized ideas

**Research Areas to Explore:**
- Raspberry Pi documentation: raspberrypi.org
- ESP32 documentation: espressif.com
- Arduino documentation: arduino.cc
- Plant care databases: USDA, university agricultural extension offices
- IoT sensor vendors: Adafruit, SparkFun, DFRobot
- Opensource hardware communities: Hackaday, Hackster.io

---

## Next Steps

### Immediate Actions

1. **Complete Project Brief Review** - Finalize this document and save to [docs/project-brief.md](docs/project-brief.md)
2. **Begin PRD Development** - Product Manager (PM) agent will create comprehensive Product Requirements Document
3. **Hardware Platform Research** - Architect will evaluate Raspberry Pi vs. ESP32 vs. Arduino with language support analysis
4. **Plant Database Source Research** - Identify authoritative sources for 50+ common garden plants
5. **Sensor Selection Research** - Evaluate specific moisture, light, and temperature sensor models

### PM Handoff

This Project Brief provides the full context for **OpenGardenLab**. The PM should:

- Review this brief thoroughly before starting PRD development
- Create PRD section by section as the template indicates
- Ask for clarification on any ambiguous requirements
- Suggest improvements or challenge assumptions where appropriate
- Focus on translating this vision into specific, actionable requirements
- Ensure MVP scope remains tight and achievable

The PRD should expand on this brief with:
- Detailed user stories and acceptance criteria
- Specific feature requirements and UI/UX expectations
- Technical requirements that inform architecture decisions
- Success metrics and validation criteria
- Epic and story breakdown for development

---

*Project Brief created using the BMAD-METHOD™ framework*
*Analyst: Mary | Date: 2025-10-01*
