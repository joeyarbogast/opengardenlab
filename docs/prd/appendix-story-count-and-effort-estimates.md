# Appendix: Story Count and Effort Estimates

## Epic Breakdown

| **Epic** | **Stories** | **Estimated Effort** | **Dependencies** |
|----------|-------------|----------------------|------------------|
| Epic 1: Foundation & Firmware | 11 stories | 3-4 weeks | Hardware arrival |
| Epic 2: Mobile App & Plant DB | 8 stories | 3-4 weeks | None (can start parallel with Epic 1) |
| Epic 3: Bluetooth Sync | 7 stories | 2-3 weeks | Epics 1 & 2 complete |
| Epic 4: Recommendations & Final Features | 7 stories | 2-3 weeks | Epic 3 complete |
| **Total** | **33 stories** | **10-14 weeks** (part-time, solo developer) | |

## Parallel Development Strategy

To optimize timeline, some epics can run in parallel:

**Weeks 1-4:**
- Epic 1 (firmware) on Raspberry Pi
- Epic 2 (mobile app) on development PC
- Plant database curation (5-10 plants)

**Weeks 5-7:**
- Epic 3 (Bluetooth integration)

**Weeks 8-10:**
- Epic 4 (recommendations, final polish)

**Estimated MVP completion:** 10-12 weeks part-time (15-20 hours/week)

---
