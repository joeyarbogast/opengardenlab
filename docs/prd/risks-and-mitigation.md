# Risks and Mitigation

| **Risk** | **Impact** | **Likelihood** | **Mitigation** |
|----------|-----------|----------------|----------------|
| **Bluetooth range insufficient** (< 30 feet) | High - renders device unusable indoors | Medium | Test Bluetooth range early (Story 3.1). If inadequate, add WiFi fallback or BLE range extender |
| **Battery life < 7 days** | Medium - frequent charging annoying | Medium | Optimize sampling interval (start with 30min instead of 15min). Add solar panel in Phase 2 if needed |
| **Sensor corrosion in outdoor environment** | Medium - sensor failure after months | Medium | Use capacitive sensors (not resistive). Test sensors outdoors for 1-2 months before full deployment |
| **Mobile app framework choice (Kotlin vs .NET MAUI) causes delays** | Medium - learning curve if unfamiliar | Low | Decide in Epic 2 Story 2.1 based on quick prototype (2-3 days testing both) |
| **Plant database curation takes longer than expected** | Low - can ship with fewer plants | Medium | Start with 10 plants instead of 25 for initial release. Expand incrementally |
| **Scope creep - adding features beyond MVP** | High - delays launch | High | Strictly defer non-MVP features to Phase 2+. Use PRD as scope gate (if not in Epic 1-4, it's out) |

---
