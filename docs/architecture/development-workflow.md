# Development Workflow

## Local Development Setup

**Prerequisites:**
- **For Firmware:** Python 3.9+, Raspberry Pi Zero 2 W, sensors
- **For Mobile:** Android Studio or Visual Studio, Android device or emulator
- **For Both:** Git, GitHub account

**Setup Steps:**

1. **Clone Repository**
   ```bash
   git clone https://github.com/yourusername/opengardenlab.git
   cd opengardenlab
   ```

2. **Firmware Development**
   ```bash
   cd firmware

   # Create virtual environment (optional but recommended)
   python3 -m venv venv
   source venv/bin/activate

   # Install dependencies
   pip install -r requirements.txt

   # Run tests
   pytest tests/

   # Run sensor service (on Pi)
   python3 src/sensor_service.py
   ```

3. **Mobile App Development**

   **Kotlin:**
   ```bash
   cd mobile-app
   ./gradlew build
   ./gradlew test

   # Run on emulator or device
   ./gradlew installDebug
   ```

4. **Plant Database Curation**
   ```bash
   cd plant-database

   # Add new plant YAML file
   nano vegetables/cucumber.yaml

   # Validate schema
   python3 ../scripts/validate-plants.sh

   # Compile to JSON
   python3 ../scripts/compile-plants.py
   # Output: mobile-app/app/src/main/assets/plants.json
   ```

**Development Commands:**

```bash
# Run all firmware tests
cd firmware && pytest tests/ -v

# Run mobile app tests
cd mobile-app && ./gradlew test

# Validate plant database
python3 scripts/validate-plants.sh

# Start firmware service manually (for debugging)
python3 firmware/src/sensor_service.py

# SSH into Raspberry Pi for live debugging
ssh pi@opengardenlab.local
tail -f /home/pi/opengardenlab/firmware/logs/sensor_service.log
```

---
