# Plant Database Research: OpenGardenLab
**Architect:** Winston
**Date:** 2025-10-01
**Status:** Final
**Project:** OpenGardenLab IoT Garden Monitoring System

---

## Executive Summary

This research evaluates data sources for **plant care requirements** (optimal moisture, light, temperature ranges) to power OpenGardenLab's recommendation engine. The MVP requires data for **50+ common vegetables, fruits, and herbs** grown by home gardeners.

### Final Recommendation

**Hybrid approach for MVP:**

1. **Primary Source:** **Manual curation** from university extension guides and authoritative gardening references
2. **Data Format:** Local JSON/YAML file bundled with mobile app (no external API dependency)
3. **Initial Coverage:** 50-75 most common home garden plants
4. **Post-MVP:** Community contributions via GitHub pull requests

**Rationale:**
- ✅ **Local-first architecture** - no API calls, works offline
- ✅ **Authoritative data** - curated from trusted sources (university extension offices)
- ✅ **Full control** - no API rate limits, deprecation, or licensing issues
- ✅ **MVP-friendly** - start small (50 plants), expand over time
- ✅ **Open source** - community can improve and validate data

**No viable API found:** While several plant APIs exist, **none provide the specific sensor-based care data** (moisture %, lux hours, soil temp ranges) needed for OpenGardenLab's use case.

---

## Plant Data Requirements

### MVP Data Schema

For each plant, OpenGardenLab needs:

```yaml
plant_name: "Tomato (Cherry)"
scientific_name: "Solanum lycopersicum var. cerasiforme"
category: "vegetable"
optimal_ranges:
  soil_moisture:
    min: 40
    max: 60
    unit: "percentage"
    notes: "Keep consistently moist, avoid waterlogged soil"
  light:
    min_hours_per_day: 6
    max_hours_per_day: 8
    min_lux: 32000
    ideal_lux: 50000
    notes: "Full sun, 6-8 hours direct sunlight"
  air_temperature:
    min_c: 18
    max_c: 29
    ideal_c: 21-24
    unit: "celsius"
    notes: "Warm season crop, sensitive to frost"
  soil_temperature:
    min_c: 15
    max_c: 30
    ideal_c: 21-24
    notes: "Will not germinate below 15°C"
  humidity:
    min: 40
    max: 70
    unit: "percentage_rh"
    notes: "Moderate humidity, good airflow prevents disease"
growth_stages:
  germination: "5-10 days at 21-27°C"
  transplant: "After last frost, soil >15°C"
  flowering: "45-60 days from transplant"
  harvest: "60-85 days from transplant"
common_problems:
  - symptom: "Blossom end rot"
    causes: ["Inconsistent watering", "Calcium deficiency"]
    sensor_indicators: "Erratic soil moisture readings"
  - symptom: "Yellowing lower leaves"
    causes: ["Overwatering", "Nitrogen deficiency"]
    sensor_indicators: "Soil moisture >70% for extended periods"
```

### Critical Data Points for MVP

**Must-have:**
- ✅ Soil moisture range (min/max %)
- ✅ Light requirements (hours/day, full sun vs partial shade)
- ✅ Air temperature range (min/max °C)

**Nice-to-have (MVP):**
- ⚠️ Soil temperature range
- ⚠️ Humidity range
- ⚠️ Growth stage timeline

**Post-MVP:**
- ⬜ pH range
- ⬜ NPK requirements
- ⬜ Common problems + sensor diagnostics

---

## Evaluated Data Sources

### 1. Trefle API (Plant Database API)

**Website:** [trefle.io](https://trefle.io/)
**Type:** RESTful API
**Status:** ⚠️ **Deprecated/Unstable** (2023)

**What it provides:**
- 400,000+ plant species
- Scientific names, taxonomy, images
- Basic growth info (height, spread, flower color)

**What it LACKS:**
- ❌ **No sensor-based care data** (no moisture %, lux, temp ranges)
- ❌ Generic "light: full sun" (not hours/day or lux values)
- ❌ Generic "water: average" (not moisture percentage)
- ❌ No temperature ranges for most plants

**Licensing:** Open API, free tier (120 requests/day)

**Example response (Tomato):**
```json
{
  "common_name": "Tomato",
  "scientific_name": "Solanum lycopersicum",
  "light": "full sun",
  "atmospheric_humidity": null,
  "minimum_precipitation": null,
  "maximum_precipitation": null,
  "minimum_temperature": null,
  "maximum_temperature": null
}
```

**Verdict:** ❌ **Not suitable.** Too generic, missing critical sensor data. API also unstable (frequent downtime reported).

---

### 2. OpenFarm Database

**Website:** [openfarm.cc](https://openfarm.cc/)
**Type:** Open-source community database (API + web scraping)
**Status:** ✅ Active, but limited data

**What it provides:**
- ~1,500 crops with growing guides
- "Sun requirements" (hours/day)
- "Water" (frequency, e.g., "daily", "weekly")
- Temperature tolerances (frost-hardy, warm season)
- Growing timeline (days to germination, harvest)

**What it LACKS:**
- ❌ **No sensor values** (no moisture %, lux, specific temp ranges)
- ⚠️ Data quality varies (user-contributed, not always verified)
- ⚠️ Limited API documentation

**Licensing:** CC0 (public domain)

**Example data (Tomato):**
```
Sun Requirements: Full sun (6-8 hours)
Water: Daily during hot weather
Temperature: Warm season, 60-85°F (15-29°C)
```

**Verdict:** ⭐⭐⭐ **Potentially useful** for initial data, but requires manual conversion to sensor values (e.g., "daily watering" → "40-60% moisture").

---

### 3. USDA Plants Database

**Website:** [plants.usda.gov](https://plants.usda.gov/)
**Type:** Government database (web interface, no API)
**Status:** ✅ Authoritative, comprehensive

**What it provides:**
- 30,000+ plant species (native and introduced)
- Hardiness zones
- Growth habit, foliage, flower info
- Conservation status

**What it LACKS:**
- ❌ **No cultivation data** (focused on identification, not gardening)
- ❌ No sensor-based care requirements
- ❌ No API (web scraping required)

**Licensing:** Public domain (U.S. government)

**Verdict:** ❌ **Not suitable.** Excellent for plant identification, but no care data for home gardens.

---

### 4. Perennial Plant Database (University of Minnesota Extension)

**Website:** [extension.umn.edu](https://extension.umn.edu/)
**Type:** Web-based plant selector
**Status:** ✅ Active, authoritative

**What it provides:**
- 3,000+ perennials, annuals, vegetables
- Light requirements (full sun, part shade, shade)
- Water needs (dry, medium, wet)
- Hardiness zones
- Bloom time, height, spread

**What it LACKS:**
- ❌ **No sensor-specific values** (qualitative only: "full sun" not lux hours)
- ❌ No API (web interface only)

**Licensing:** Public (educational use)

**Verdict:** ⭐⭐⭐ **Useful reference** for manual curation, but no API or sensor data.

---

### 5. Royal Horticultural Society (RHS) Plant Finder

**Website:** [rhs.org.uk/plants](https://www.rhs.org.uk/plants)
**Type:** Web database (UK-focused)
**Status:** ✅ Very authoritative

**What it provides:**
- 80,000+ plants
- Light, soil, moisture requirements (qualitative)
- Hardiness ratings
- Care guides

**What it LACKS:**
- ❌ **No sensor values** (qualitative descriptions only)
- ❌ No API
- ⚠️ UK-focused (different climate zones)

**Licensing:** Proprietary (RHS membership required for full access)

**Verdict:** ⭐⭐ **Not suitable** for MVP (no API, UK-centric, no sensor data).

---

### 6. Gardenia Plant Database

**Website:** [gardenia.net](https://www.gardenia.net/)
**Type:** Commercial plant database
**Status:** ✅ Active

**What it provides:**
- 20,000+ plants
- Detailed care guides (light, water, soil, temperature)
- Growing zones
- Photos

**What it LACKS:**
- ❌ **No API** (web interface only, proprietary)
- ❌ **No sensor values** (qualitative: "keep soil moist" not "40-60% moisture")
- ⚠️ Subscription required for full access

**Licensing:** Proprietary (commercial)

**Verdict:** ❌ **Not suitable** (no API, not open-source, qualitative data).

---

### 7. University Extension Office Guides

**Examples:**
- [UC Davis Vegetable Research](https://vric.ucdavis.edu/)
- [Cornell Vegetable Program](https://cvp.cce.cornell.edu/)
- [Oregon State Extension](https://extension.oregonstate.edu/)
- [North Carolina Extension Gardener](https://plants.ces.ncsu.edu/)

**Type:** Educational resources (PDFs, web pages)
**Status:** ✅ Highly authoritative

**What they provide:**
- **Specific temperature ranges** (germination, growth, optimal)
- **Water requirements** (inches/week, soil moisture management)
- **Light requirements** (hours/day, full sun vs shade)
- **Soil temperature** (planting depth, germination temps)
- **Growth timelines** (days to germination, transplant, harvest)

**Example (Tomato from UC Davis):**
```
Germination soil temp: 60-85°F (optimal 75-80°F)
Growing temp: 70-75°F day, 60-65°F night
Light: Full sun (8+ hours)
Water: 1-2 inches per week, consistent moisture
Soil moisture: Keep evenly moist, not waterlogged
```

**What they LACK:**
- ❌ **No API** (manual data entry required)
- ⚠️ Format varies (PDFs, tables, prose)

**Licensing:** Public domain (educational, U.S. government or state-funded)

**Verdict:** ⭐⭐⭐⭐⭐ **BEST SOURCE for authoritative data**, but requires **manual curation** (no API).

---

### 8. The Old Farmer's Almanac Plant Library

**Website:** [almanac.com/plants](https://www.almanac.com/plants)
**Type:** Commercial database
**Status:** ✅ Active, popular

**What it provides:**
- 250+ vegetables, fruits, herbs, flowers
- Growing guides (sun, water, soil, temperature)
- Planting calendar by ZIP code
- Companion planting

**What it LACKS:**
- ❌ **No API** (web scraping possible but ToS violations)
- ❌ **No sensor values** (qualitative descriptions)

**Licensing:** Proprietary (commercial)

**Verdict:** ⭐⭐⭐ **Good reference** for manual curation, but no programmatic access.

---

### 9. iNaturalist / PlantNet (Image Recognition APIs)

**Websites:** [inaturalist.org](https://www.inaturalist.org/), [plantnet.org](https://plantnet.org/)
**Type:** Image-based plant identification APIs
**Status:** ✅ Active

**What they provide:**
- Image → plant species identification
- Taxonomy, common names
- Geographic distribution

**What they LACK:**
- ❌ **No care data** (identification only, not cultivation)

**Licensing:** Open API (iNaturalist), Academic (PlantNet)

**Verdict:** ❌ **Not suitable for MVP.** Useful for **Phase 2+** (camera-based plant ID), but no care data.

---

### 10. Community-Sourced GitHub Datasets

**Examples:**
- [harvesthelper/plant-database](https://github.com/harvesthelper/plant-database) (abandoned)
- [openfarm/openfarm](https://github.com/openfarm/openfarm) (active, but limited sensor data)

**Type:** Open-source JSON/CSV datasets
**Status:** ⚠️ Mostly abandoned or incomplete

**What they provide:**
- JSON/CSV plant lists
- Varying data quality (community-contributed)

**What they LACK:**
- ⚠️ **Inconsistent schema** (no standard format)
- ⚠️ **Data gaps** (many plants missing key fields)
- ❌ **No sensor values** (qualitative descriptions)

**Licensing:** Varies (MIT, CC0, GPL)

**Verdict:** ⭐⭐ **Potentially useful** for inspiration, but requires significant cleanup and augmentation.

---

## Comparative Analysis

### API Availability

| **Source** | **API?** | **Sensor Data?** | **Coverage** | **License** | **Verdict** |
|------------|----------|------------------|--------------|-------------|-------------|
| Trefle | ✅ Yes (unstable) | ❌ No | 400k+ species | Open | ❌ Not suitable |
| OpenFarm | ⚠️ Limited | ❌ No | 1,500 crops | CC0 | ⚠️ Reference only |
| USDA Plants | ❌ No | ❌ No | 30k species | Public domain | ❌ Not suitable |
| University Extensions | ❌ No | ✅ **Yes** | 50-100 crops | Public domain | ⭐⭐⭐⭐⭐ **Best** |
| RHS Plant Finder | ❌ No | ❌ No | 80k plants | Proprietary | ❌ Not suitable |
| Old Farmer's Almanac | ❌ No | ⚠️ Partial | 250+ crops | Proprietary | ⭐⭐⭐ Reference |
| GitHub Datasets | N/A | ❌ No | Varies | Open | ⚠️ Inspiration |

**Conclusion:** **No comprehensive API** provides sensor-based care data. Manual curation from **university extension guides** is the only viable path.

---

## Recommended Approach: Manual Curation

### Why Manual Curation?

**No API solves the problem:**
- Existing APIs lack sensor-specific data (moisture %, lux, temp ranges)
- Qualitative descriptions ("full sun", "keep moist") require human interpretation
- University extension guides have the data, but not in API format

**Benefits of manual curation:**
- ✅ **Authoritative data** - university extension offices are gold standard
- ✅ **Local-first** - no external API dependency (aligns with project vision)
- ✅ **Offline-capable** - all data bundled with mobile app
- ✅ **Full control** - no rate limits, API changes, or deprecation
- ✅ **Community-improvable** - open-source, accept contributions via GitHub

**Manageable scope:**
- Start with **50-75 most common plants** (tomatoes, peppers, lettuce, basil, etc.)
- Expand over time via community contributions
- 2-3 hours per plant to research and document = ~100-150 hours total (spread over MVP development)

---

### MVP Plant List (Prioritized)

**Tier 1: Top 25 Most Common Home Garden Plants** (Launch MVP with these)

**Vegetables:**
1. Tomato (cherry, beefsteak, roma)
2. Pepper (bell, jalapeño, banana)
3. Lettuce (leaf, romaine, iceberg)
4. Cucumber
5. Zucchini / Summer Squash
6. Carrot
7. Radish
8. Green Beans
9. Peas (snap, snow)
10. Onion / Scallion
11. Potato
12. Spinach
13. Kale
14. Broccoli
15. Cauliflower

**Herbs:**
16. Basil
17. Cilantro
18. Parsley
19. Mint
20. Oregano
21. Thyme
22. Rosemary
23. Dill

**Fruits:**
24. Strawberry
25. Blueberry

---

**Tier 2: Next 25 Popular Plants** (Add post-MVP)

26. Eggplant
27. Swiss Chard
28. Beet
29. Cabbage
30. Brussels Sprouts
31. Squash (winter)
32. Pumpkin
33. Watermelon
34. Cantaloupe
35. Corn
36. Celery
37. Leek
38. Turnip
39. Arugula
40. Bok Choy
41. Collard Greens
42. Mustard Greens
43. Kohlrabi
44. Fennel
45. Chives
46. Sage
47. Lavender
48. Tarragon
49. Marjoram
50. Raspberry

---

### Data Curation Workflow

**Step 1: Research** (30-45 min/plant)
- Search university extension guides for plant
  - UC Davis Vegetable Research
  - Cornell Cooperative Extension
  - Oregon State Extension
  - Your local state extension office
- Extract data:
  - Temperature ranges (germination, growth, optimal)
  - Light hours (full sun = 6-8hrs, partial shade = 3-6hrs)
  - Water requirements (inches/week → convert to soil moisture %)
  - Soil temperature (planting, growth)
  - Growth timeline (days to germination, harvest)

**Step 2: Convert to Sensor Values** (15-30 min/plant)
- **Light conversion:**
  - "Full sun" = 6-8 hours = 32,000-50,000 lux
  - "Partial sun" = 4-6 hours = 15,000-25,000 lux
  - "Shade" = 2-4 hours = 5,000-15,000 lux

- **Water/Moisture conversion:**
  - "1-2 inches/week" = 40-60% soil moisture (keep evenly moist)
  - "Drought tolerant" = 20-40% soil moisture
  - "Keep moist" = 50-70% soil moisture
  - "Wet soil" = 70-85% soil moisture

- **Temperature:** Direct conversion (°F → °C)

**Step 3: Document in YAML** (10-15 min/plant)

```yaml
# plants/tomato-cherry.yaml
common_name: "Cherry Tomato"
scientific_name: "Solanum lycopersicum var. cerasiforme"
category: "vegetable"
family: "Solanaceae"

optimal_ranges:
  soil_moisture:
    min: 40
    max: 60
    unit: "percentage"
    notes: "Keep consistently moist but not waterlogged"

  light:
    hours_per_day: 6-8
    min_lux: 32000
    ideal_lux: 50000
    description: "Full sun"

  air_temperature:
    min_c: 18
    max_c: 29
    ideal_c: 21-24
    min_f: 65
    max_f: 85
    ideal_f: 70-75

  soil_temperature:
    germination_min_c: 15
    germination_ideal_c: 21-27
    growth_min_c: 18

growth_info:
  days_to_germination: "5-10"
  days_to_transplant: "45-60"
  days_to_harvest: "60-85"
  season: "warm"
  frost_tolerance: "none"

sources:
  - "UC Davis Vegetable Research: Tomato Production"
  - "Cornell Cooperative Extension: Growing Tomatoes"
  - url: "https://vric.ucdavis.edu/pdf/tomato/TOMATOPRODUCTION.pdf"
```

**Step 4: Validate** (5-10 min/plant)
- Cross-reference with 2-3 sources (avoid single-source errors)
- Compare to community knowledge (gardening forums, your experience)

**Total time per plant:** ~60-90 minutes
**Total for 50 plants:** ~50-75 hours (doable over 2-3 months part-time)

---

### Data Format & Storage

**Recommendation:** **YAML files** in Git repository

**Structure:**
```
gardenapp/
├── data/
│   ├── plants/
│   │   ├── vegetables/
│   │   │   ├── tomato-cherry.yaml
│   │   │   ├── tomato-beefsteak.yaml
│   │   │   ├── pepper-bell.yaml
│   │   │   └── ...
│   │   ├── herbs/
│   │   │   ├── basil.yaml
│   │   │   ├── cilantro.yaml
│   │   │   └── ...
│   │   └── fruits/
│   │       ├── strawberry.yaml
│   │       └── ...
│   └── schema/
│       └── plant-schema.yaml  # JSON schema for validation
├── mobile-app/
│   └── assets/
│       └── plants.json  # Compiled from YAML for app bundling
└── scripts/
    └── compile-plants.py  # YAML → JSON converter
```

**Why YAML?**
- ✅ **Human-readable** - easy for contributors to edit
- ✅ **Git-friendly** - diff/merge, track changes over time
- ✅ **Commenting** - add notes, sources, caveats
- ✅ **Validation** - JSON schema can validate structure
- ✅ **Compile to JSON** - mobile app uses JSON (smaller, faster parsing)

**Why NOT a database API?**
- ❌ **Local-first architecture** - no cloud dependency
- ❌ **Offline-first mobile app** - all data bundled
- ❌ **No need for dynamic data** - plant care ranges don't change daily
- ✅ **Version control** - Git tracks all changes, community PRs

---

## Post-MVP: Community Contributions

### GitHub-Based Contribution Model

**How it works:**
1. **Plant data lives in GitHub repo** (e.g., `opengardendab/plant-data`)
2. **Contributors submit pull requests** to add/improve plant profiles
3. **Maintainers review** for accuracy (cross-reference sources)
4. **Merge approved PRs** → trigger CI/CD to compile YAML → JSON
5. **Mobile app updates** pull new plants.json on next release

**Contribution template (GitHub PR template):**
```markdown
## New Plant: [Plant Name]

**Common Name:** Cherry Tomato
**Scientific Name:** Solanum lycopersicum var. cerasiforme
**Category:** Vegetable

**Sources (minimum 2):**
- [ ] UC Davis Vegetable Research
- [ ] Cornell Extension
- [ ] Oregon State Extension
- [ ] Other: _______________

**Data Checklist:**
- [ ] Soil moisture range (min/max %)
- [ ] Light requirements (hours/day, lux)
- [ ] Air temperature range (°C)
- [ ] Soil temperature (optional)
- [ ] Growth timeline (optional)

**Validation:**
- [ ] Cross-referenced with 2+ authoritative sources
- [ ] Tested in my garden (optional)
- [ ] YAML passes schema validation (automated check)
```

**Quality control:**
- Require 2+ authoritative sources per plant
- Maintainers verify data before merge
- Automated tests check YAML schema validity
- Community can report errors via GitHub issues

---

## Alternative: Hybrid Approach (Future)

**Phase 1 (MVP):** Manual curated plant database (50-75 plants)

**Phase 2 (Community Growth):**
- Accept GitHub PR contributions
- Expand to 100-200 plants via community

**Phase 3 (Advanced):**
- Optional: Integrate with image recognition API (iNaturalist, PlantNet)
- User uploads photo → app identifies plant → loads care profile from local database
- Still local-first (all plant data bundled), but enhanced discovery

**Phase 4 (Machine Learning - Speculative):**
- Collect anonymized sensor data + plant type + outcomes (good/bad harvest)
- Train ML model to refine optimal ranges per region/microclimate
- "Tomatoes in Seattle need 50-65% moisture, not 40-60%"
- Still local-first (model runs on-device or Pi)

---

## Data Licensing Considerations

### Source Data Licensing

**University Extension Guides:**
- **License:** Public domain (U.S. government work, state-funded)
- **Usage:** Can use freely, but cite sources
- **Recommendation:** Add attribution in each plant YAML file

**Example attribution:**
```yaml
sources:
  - name: "UC Davis Vegetable Research"
    url: "https://vric.ucdavis.edu/pdf/tomato/TOMATOPRODUCTION.pdf"
    license: "Public domain (U.S. government work)"
```

### OpenGardenLab Plant Database License

**Recommendation:** **CC0 (Public Domain)** or **CC-BY 4.0**

**CC0 (Public Domain):**
- ✅ Maximum openness (no attribution required)
- ✅ Aligns with local-first, community-driven vision
- ✅ Easy for others to remix, improve, redistribute
- ⚠️ No control over commercial use (others could create paid apps with your data)

**CC-BY 4.0 (Attribution):**
- ✅ Requires attribution to OpenGardenLab
- ✅ Prevents uncredited commercial use
- ✅ Still open-source friendly
- ⚠️ Slightly more restrictive (some projects avoid CC-BY)

**Recommendation:** **CC0** for maximum community adoption. Plant care data should be freely available to help all gardeners.

---

## MVP Implementation Plan

### Timeline (Parallel with Development)

**Weeks 1-2:** Research workflow setup
- Identify top 25 plants for MVP
- Create YAML schema template
- Set up Git repo structure (`data/plants/`)

**Weeks 3-6:** Curate Tier 1 plants (25 plants)
- ~6-7 plants per week (1-2 hours each)
- Focus on most common: tomatoes, peppers, lettuce, herbs

**Weeks 7-10:** Validate and refine
- Cross-reference data with multiple sources
- Test YAML → JSON compilation script
- Bundle with mobile app

**Weeks 11-12:** Expand to 50 plants (Tier 2)
- Add next 25 popular plants
- Open GitHub for community contributions

**Total effort:** ~50-75 hours over 3 months (parallel with firmware/app development)

---

## Sample Plant Profiles (Examples)

### Example 1: Cherry Tomato

```yaml
common_name: "Cherry Tomato"
scientific_name: "Solanum lycopersicum var. cerasiforme"
category: "vegetable"
family: "Solanaceae"

optimal_ranges:
  soil_moisture:
    min: 40
    max: 60
    unit: "percentage"
    notes: "Keep consistently moist. Avoid waterlogged soil."

  light:
    hours_per_day_min: 6
    hours_per_day_max: 10
    min_lux: 32000
    ideal_lux: 50000
    description: "Full sun"

  air_temperature:
    min_c: 18
    max_c: 29
    ideal_c: 21
    ideal_range_c: "21-24"
    frost_tolerance: "none"

  soil_temperature:
    germination_min_c: 15
    germination_ideal_c: 24
    growth_min_c: 18

  humidity:
    min: 40
    max: 70
    notes: "Moderate humidity, good airflow"

growth_info:
  days_to_germination: "5-10"
  days_to_transplant: "45-60 (after last frost)"
  days_to_harvest: "60-85 from transplant"
  season: "warm"
  hardiness_zones: "3-11 (annual)"

common_issues:
  - symptom: "Blossom end rot"
    causes: ["Inconsistent watering", "Calcium deficiency"]
    sensor_clue: "Erratic soil moisture readings"

  - symptom: "Yellowing lower leaves"
    causes: ["Overwatering", "Nitrogen deficiency"]
    sensor_clue: "Soil moisture >70% sustained"

sources:
  - name: "UC Davis Vegetable Research: Tomato Production"
    url: "https://vric.ucdavis.edu/pdf/tomato/TOMATOPRODUCTION.pdf"
  - name: "Cornell Cooperative Extension: Growing Tomatoes"
    url: "https://gardening.cals.cornell.edu/lessons/crops/tomatoes/"

curated_by: "OpenGardenLab Team"
date_created: "2025-10-01"
date_updated: "2025-10-01"
```

---

### Example 2: Basil

```yaml
common_name: "Basil"
scientific_name: "Ocimum basilicum"
category: "herb"
family: "Lamiaceae"

optimal_ranges:
  soil_moisture:
    min: 50
    max: 70
    unit: "percentage"
    notes: "Keep soil consistently moist, but not waterlogged"

  light:
    hours_per_day_min: 6
    hours_per_day_max: 8
    min_lux: 25000
    ideal_lux: 40000
    description: "Full sun to partial shade"

  air_temperature:
    min_c: 18
    max_c: 32
    ideal_c: 21
    ideal_range_c: "21-27"
    frost_tolerance: "none"

  soil_temperature:
    germination_min_c: 21
    germination_ideal_c: 24

growth_info:
  days_to_germination: "5-10"
  days_to_harvest: "60-90 (continuous harvest)"
  season: "warm"
  hardiness_zones: "10-11 (perennial), 2-11 (annual)"

common_issues:
  - symptom: "Yellowing leaves"
    causes: ["Overwatering", "Nutrient deficiency"]
    sensor_clue: "Soil moisture >75% sustained"

  - symptom: "Wilting despite moist soil"
    causes: ["Root rot from overwatering"]
    sensor_clue: "High soil moisture + warm temps"

sources:
  - name: "Oregon State Extension: Growing Basil"
    url: "https://extension.oregonstate.edu/gardening/herbs/basil"
  - name: "Cornell Cooperative Extension: Basil"
    url: "https://gardening.cals.cornell.edu/lessons/crops/basil/"

curated_by: "OpenGardenLab Team"
date_created: "2025-10-01"
```

---

## Next Steps

1. ✅ **Plant Database Research Complete:** Manual curation from university extension guides is best approach
2. **Set up data repository:**
   - Create `data/plants/` folder structure
   - Write plant YAML schema
   - Create validation script
3. **Begin curation (Tier 1):**
   - Start with top 10 most common plants (tomato, pepper, lettuce, basil, etc.)
   - Allocate 2-3 hours/week during MVP development
4. **Complete PRD Development (Next):** PM agent creates Product Requirements Document informed by all research
5. **Architecture Design:** System architecture incorporating plant database (bundled with mobile app)

---

## Appendices

### A. University Extension Office Directory

**Top Resources for Plant Care Data:**

1. **UC Davis Vegetable Research & Information Center**
   - URL: [vric.ucdavis.edu](https://vric.ucdavis.edu/)
   - Coverage: Vegetables, fruits, detailed production guides

2. **Cornell Cooperative Extension (NY)**
   - URL: [gardening.cals.cornell.edu](https://gardening.cals.cornell.edu/)
   - Coverage: Vegetables, herbs, fruits, ornamentals

3. **Oregon State University Extension**
   - URL: [extension.oregonstate.edu/gardening](https://extension.oregonstate.edu/gardening)
   - Coverage: Pacific Northwest climate, vegetables, herbs

4. **North Carolina Extension Gardener**
   - URL: [plants.ces.ncsu.edu](https://plants.ces.ncsu.edu/)
   - Coverage: Southern climate, warm-season crops

5. **University of Minnesota Extension**
   - URL: [extension.umn.edu/yard-and-garden](https://extension.umn.edu/yard-and-garden)
   - Coverage: Cold-climate gardening, short-season crops

6. **Texas A&M AgriLife Extension**
   - URL: [aggie-horticulture.tamu.edu](https://aggie-horticulture.tamu.edu/)
   - Coverage: Hot, dry climate, drought-tolerant crops

---

### B. Plant Data Schema (JSON Schema)

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "OpenGardenLab Plant Profile",
  "type": "object",
  "required": ["common_name", "scientific_name", "category", "optimal_ranges"],
  "properties": {
    "common_name": { "type": "string" },
    "scientific_name": { "type": "string" },
    "category": { "enum": ["vegetable", "fruit", "herb", "flower"] },
    "optimal_ranges": {
      "type": "object",
      "required": ["soil_moisture", "light", "air_temperature"],
      "properties": {
        "soil_moisture": {
          "type": "object",
          "required": ["min", "max", "unit"],
          "properties": {
            "min": { "type": "number", "minimum": 0, "maximum": 100 },
            "max": { "type": "number", "minimum": 0, "maximum": 100 },
            "unit": { "const": "percentage" },
            "notes": { "type": "string" }
          }
        },
        "light": {
          "type": "object",
          "required": ["hours_per_day_min", "min_lux", "description"],
          "properties": {
            "hours_per_day_min": { "type": "number" },
            "hours_per_day_max": { "type": "number" },
            "min_lux": { "type": "number" },
            "ideal_lux": { "type": "number" },
            "description": { "type": "string" }
          }
        },
        "air_temperature": {
          "type": "object",
          "required": ["min_c", "max_c"],
          "properties": {
            "min_c": { "type": "number" },
            "max_c": { "type": "number" },
            "ideal_c": { "type": "number" },
            "frost_tolerance": { "enum": ["none", "light", "moderate", "heavy"] }
          }
        }
      }
    },
    "sources": {
      "type": "array",
      "minItems": 1,
      "items": {
        "type": "object",
        "required": ["name"],
        "properties": {
          "name": { "type": "string" },
          "url": { "type": "string", "format": "uri" }
        }
      }
    }
  }
}
```

---

### C. Lux Conversion Reference

| **Light Condition** | **Hours/Day** | **Lux Range** | **Example Plants** |
|---------------------|---------------|---------------|-------------------|
| **Full Sun** | 6-8+ | 32,000-50,000+ | Tomato, Pepper, Cucumber, Basil |
| **Partial Sun** | 4-6 | 15,000-25,000 | Lettuce, Spinach, Broccoli |
| **Partial Shade** | 3-4 | 10,000-15,000 | Arugula, Cilantro, Mint |
| **Full Shade** | 2-3 | 5,000-10,000 | Hostas, Ferns (ornamentals) |

**Note:** These are approximations. Actual lux varies by latitude, season, cloud cover. The sensor measures real-world conditions.

---

### D. Soil Moisture Conversion Reference

| **Description** | **Soil Moisture %** | **Example Plants** |
|-----------------|---------------------|-------------------|
| **Dry / Drought Tolerant** | 20-40% | Rosemary, Thyme, Lavender |
| **Evenly Moist** | 40-60% | Tomato, Pepper, Beans, Peas |
| **Keep Moist** | 50-70% | Lettuce, Spinach, Basil, Cilantro |
| **Wet Soil** | 70-85% | Rice, Watercress, Bog plants |

**Calibration note:** Absolute percentages vary by soil type (clay vs sand). Users should calibrate sensor in their specific soil.

---

*Plant Database Research completed using the BMAD-METHOD™ framework*
*Architect: Winston | Date: 2025-10-01*
