## Story 1.8: Logging and Health Check Indicator

**Story File:** `docs/stories/1.8.logging-health-check-indicator.md`

**As a** developer,
**I want** structured logging and a visual health indicator (LED or console message),
**so that** I can monitor firmware status and troubleshoot issues during development.

### Acceptance Criteria
1. Python logging configured with rotating file handler: `firmware/logs/sensor_service.log`
2. Log levels used appropriately:
   - INFO: Successful sensor readings ("Read sensors: moisture=45%, lux=12000, temp=22°C")
   - WARNING: Sensor read errors ("Failed to read BH1750, retrying...")
   - ERROR: Critical failures ("Database connection failed")
3. Optional: GPIO LED blink every sampling cycle (LED on Pin 17, blinks for 1 second after each successful reading)
4. Logs rotate after 10MB, keep last 5 log files
5. SSH into Pi, tail logs in real-time (`tail -f firmware/logs/sensor_service.log`) to observe sampling

### Labels
- `epic-1`
- `story`
