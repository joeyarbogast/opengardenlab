# User Interface Design Goals

## Overall UX Vision

The mobile app should feel like a **friendly garden assistant** that helps you understand what's happening in your garden without overwhelming you with data. The core experience is:
1. **Glanceable status** - quickly see if plants are happy or need attention
2. **Clear recommendations** - actionable guidance in plain language (not just numbers)
3. **Trend awareness** - beautiful charts that make patterns obvious (moisture dropping, light increasing over spring)
4. **Low friction** - minimal setup, automatic data sync, works offline

Target feeling: **Confidence, not confusion.** Users should feel empowered to make informed decisions, not paralyzed by data.

## Key Interaction Paradigms

**Data-First, Not Configuration-Heavy:**
- Primary flow: Open app → See latest data immediately → Review recommendations
- Not: Navigate through menus to find settings → Configure thresholds → Then see data

**Progressive Disclosure:**
- MVP shows essential info first (current readings, status, simple recommendations)
- Tap to drill down for detailed charts, historical trends, journal entries
- Advanced features (multi-device management, calibration) accessible but not front-and-center

**Offline-First:**
- All core features work without internet (view data, recommendations, add journal entries)
- Bluetooth sync is explicit user action (tap "Sync" button when in range)
- Clear sync status indicator (last synced timestamp, "sync needed" badge)

## Core Screens and Views

MVP requires these essential screens:

1. **Device Dashboard** - Primary screen after opening app
   - Current sensor readings (moisture %, lux, temp, humidity) with color-coded status
   - Assigned plant info (photo, name, optimal ranges)
   - Simple recommendation banner (e.g., "Soil is drier than optimal. Consider watering.")
   - Last sync timestamp
   - Quick access to: Sync button, historical charts, device settings

2. **Historical Data / Charts** - Tap on any sensor reading
   - Time-series line charts for each sensor (moisture, light, temp, humidity)
   - View options: 24 hours, 7 days, 30 days
   - Overlay optimal range (shaded area) vs actual readings (line graph)
   - Identify trends visually (e.g., moisture declining, light hours increasing)

3. **Plant Selection** - Assign plant type to device
   - Browse or search plant database (50+ plants)
   - Categorized: Vegetables, Fruits, Herbs
   - View optimal ranges for each plant before assigning
   - Quick assign (one tap to confirm)

4. **Recommendations / Insights** - Dedicated recommendations view
   - List of current recommendations (moisture low, light too high, etc.)
   - Trend-based insights (e.g., "Moisture has dropped 20% over last 3 days")
   - Explain WHY (compare to plant's optimal range)
   - Suggested actions ("Water 1-2 cups daily until moisture reaches 40-60%")

5. **Garden Journal** - Note-taking
   - Chronological list of user notes + auto-generated entries (e.g., "Device synced", "Plant assigned")
   - Add note: text entry, timestamp auto-added
   - Attach to specific device/zone
   - Filter by device, date range

6. **Device List / Multi-Device** - Switch between devices
   - List of all paired devices with labels ("Tomato Bed", "Herb Garden")
   - Quick device switcher (swipe or dropdown)
   - Add new device (Bluetooth pairing flow)
   - Edit device name/label

7. **Device Settings / Calibration**
   - Configure sampling interval (15 min, 30 min, 60 min)
   - Run soil moisture calibration (air reading, water reading)
   - View device info (Raspberry Pi ID, firmware version, storage usage)
   - Unpair device

## Accessibility

**Target:** WCAG AA compliance (MVP)

Specific requirements:
- Minimum touch target size: 44x44 points (iOS) / 48x48dp (Android)
- Color is not the only indicator (use icons + text for status: red + ⚠️ for "low moisture")
- Text contrast ratio ≥4.5:1 for normal text, ≥3:1 for large text
- Support system font size preferences (scale UI text)
- All interactive elements have accessible labels for screen readers

## Branding

**Style:** Clean, modern, gardening-inspired

- **Color palette:**
  - Primary: Earthy green (#4CAF50 or similar - represents healthy plants)
  - Accent: Warm orange/amber (#FF9800 - represents alerts/sun)
  - Backgrounds: White/light gray (clean, readable)
  - Status colors: Green (good), Yellow (caution), Red (alert)

- **Typography:**
  - Sans-serif, readable (Roboto on Android, system default)
  - Clear hierarchy (large titles, readable body text)

- **Imagery:**
  - Plant photos from plant database (show assigned plant on dashboard)
  - Icons for sensors (droplet for moisture, sun for light, thermometer for temp)

- **Tone:**
  - Friendly, encouraging, educational (not technical/intimidating)
  - Example: "Your tomatoes are loving that sunshine! ☀️" vs "Lux reading: 45,000"

## Target Device and Platforms

**MVP:** Android native app only
- Minimum Android version: TBD (likely Android 8.0+ for Bluetooth LE APIs)
- Target: Phones and tablets (responsive layout)
- Screen sizes: 5" to 10" (optimize for typical phone size ~6")

**Post-MVP:** iOS, web dashboard (future phases)

**Why Android-first:**
- Developer has Android device for testing
- Bluetooth LE APIs well-supported on Android 8.0+
- Faster development (native Android or .NET MAUI leveraging .NET background)

---
