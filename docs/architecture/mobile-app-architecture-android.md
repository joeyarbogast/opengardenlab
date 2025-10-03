# Mobile App Architecture (Android)

## Component Overview

The Android mobile app follows a **layered architecture** with clear separation between UI, business logic, data access, and external communication (Bluetooth).

**Architecture Pattern:** MVVM (Model-View-ViewModel) or similar reactive pattern

```
┌──────────────────────────────────────────────────────────┐
│                    UI Layer                              │
│  Activities/Fragments, Composables (if Jetpack Compose) │
│  Dashboard, Charts, Settings, Plant Selection           │
└────────────────┬─────────────────────────────────────────┘
                 │ Observes state
                 ▼
┌──────────────────────────────────────────────────────────┐
│               ViewModel Layer                            │
│  DashboardViewModel, ChartsViewModel, etc.               │
│  State management, business logic orchestration          │
└──┬──────────┬──────────────────┬────────────────────────┘
   │          │                  │
   │          │                  │ Queries data
   ▼          ▼                  ▼
┌─────────┐ ┌──────────────┐ ┌────────────────────────┐
│ BLE     │ │ Recommend    │ │ Repository Layer       │
│ Client  │ │ Engine       │ │ SensorReadingRepo,     │
│         │ │              │ │ DeviceRepo, PlantRepo  │
└─────────┘ └──────────────┘ └───────┬────────────────┘
                                      │ Reads/writes
                                      ▼
                            ┌──────────────────────┐
                            │   Data Layer         │
                            │  Room DB (SQLite)    │
                            │  JSON plant database │
                            └──────────────────────┘
```

**Key Architectural Decisions:**
- **Repository Pattern** - Abstracts data sources (SQLite, Bluetooth, JSON)
- **Offline-First** - App works fully without Bluetooth connection
- **Reactive UI** - ViewModels expose state as LiveData/Flow, UI observes changes
- **Single Source of Truth** - Local SQLite database is canonical data source

---

## Component 1: Data Layer

**Purpose:** Local storage and data access for sensor readings, devices, and plant database.

**Location:** `mobile-app/app/src/main/java/com/opengardenlab/data/`

### Database Schema (Room)

**Kotlin Room Example:**

```kotlin
// Entity: SensorReading
@Entity(tableName = "sensor_readings")
data class SensorReading(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    @ColumnInfo(name = "device_id") val deviceId: String,
    val timestamp: String, // ISO 8601
    @ColumnInfo(name = "soil_moisture") val soilMoisture: Double,
    @ColumnInfo(name = "soil_temp_stemma") val soilTempStemma: Double,
    @ColumnInfo(name = "soil_temp_ds18b20") val soilTempDs18b20: Double?,
    @ColumnInfo(name = "light_lux") val lightLux: Double,
    @ColumnInfo(name = "air_temp") val airTemp: Double,
    @ColumnInfo(name = "air_humidity") val airHumidity: Double
)

// Entity: Device
@Entity(tableName = "devices")
data class Device(
    @PrimaryKey val id: String, // Bluetooth MAC or UUID
    val name: String,
    @ColumnInfo(name = "assigned_plant_id") val assignedPlantId: String?,
    @ColumnInfo(name = "last_synced") val lastSynced: String?,
    @ColumnInfo(name = "sampling_interval_minutes") val samplingIntervalMinutes: Int,
    @ColumnInfo(name = "calibration_air_value") val calibrationAirValue: Int,
    @ColumnInfo(name = "calibration_water_value") val calibrationWaterValue: Int
)

// Entity: JournalEntry
@Entity(tableName = "journal_entries")
data class JournalEntry(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    @ColumnInfo(name = "device_id") val deviceId: String,
    val timestamp: String,
    @ColumnInfo(name = "entry_type") val entryType: String, // "user_note" or "system_event"
    val content: String
)

// DAO: SensorReadingDao
@Dao
interface SensorReadingDao {
    @Insert
    suspend fun insertAll(readings: List<SensorReading>)

    @Query("SELECT * FROM sensor_readings WHERE device_id = :deviceId AND timestamp > :since ORDER BY timestamp ASC")
    fun getReadingsSince(deviceId: String, since: String): Flow<List<SensorReading>>

    @Query("SELECT * FROM sensor_readings WHERE device_id = :deviceId ORDER BY timestamp DESC LIMIT 1")
    suspend fun getLatestReading(deviceId: String): SensorReading?

    @Query("SELECT * FROM sensor_readings WHERE device_id = :deviceId AND timestamp >= :startTime AND timestamp <= :endTime ORDER BY timestamp ASC")
    suspend fun getReadingsInRange(deviceId: String, startTime: String, endTime: String): List<SensorReading>
}

// DAO: DeviceDao
@Dao
interface DeviceDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertDevice(device: Device)

    @Query("SELECT * FROM devices")
    fun getAllDevices(): Flow<List<Device>>

    @Query("SELECT * FROM devices WHERE id = :deviceId")
    suspend fun getDevice(deviceId: String): Device?

    @Update
    suspend fun updateDevice(device: Device)
}

// Database
@Database(entities = [SensorReading::class, Device::class, JournalEntry::class], version = 1)
abstract class OpenGardenLabDatabase : RoomDatabase() {
    abstract fun sensorReadingDao(): SensorReadingDao
    abstract fun deviceDao(): DeviceDao
    abstract fun journalEntryDao(): JournalEntryDao
}
```

### Plant Database Loader

**Purpose:** Load compiled `plants.json` from app assets and provide query interface.

```kotlin
// Data class for Plant
data class Plant(
    val id: String,
    val commonName: String,
    val scientificName: String,
    val category: String, // "vegetable", "herb", "fruit"
    val soilMoisture: SoilMoistureRange,
    val light: LightRequirements,
    val airTemp: TemperatureRange,
    val humidity: HumidityRange?,
    val sources: List<Source>
)

data class SoilMoistureRange(val min: Double, val max: Double, val notes: String)
data class LightRequirements(val hoursPerDay: Double, val minLux: Double, val idealLux: Double, val notes: String)
data class TemperatureRange(val minC: Double, val maxC: Double, val idealC: Double, val notes: String)
data class HumidityRange(val min: Double, val max: Double, val notes: String)
data class Source(val name: String, val url: String)

// Plant Database Service
class PlantDatabaseService(private val context: Context) {
    private val plants: List<Plant> by lazy {
        loadPlantsFromAssets()
    }

    private fun loadPlantsFromAssets(): List<Plant> {
        val json = context.assets.open("plants.json").bufferedReader().use { it.readText() }
        val gson = Gson()
        return gson.fromJson(json, Array<Plant>::class.java).toList()
    }

    fun getAllPlants(): List<Plant> = plants

    fun searchPlants(query: String): List<Plant> =
        plants.filter { it.commonName.contains(query, ignoreCase = true) }

    fun getPlantsByCategory(category: String): List<Plant> =
        plants.filter { it.category == category }

    fun getPlantById(id: String): Plant? =
        plants.find { it.id == id }
}
```

---

## Component 2: Repository Layer

**Purpose:** Abstract data sources (SQLite, Bluetooth, JSON) and provide clean API to ViewModels.

**Location:** `mobile-app/app/src/main/java/com/opengardenlab/repository/`

```kotlin
// SensorReadingRepository
class SensorReadingRepository(
    private val dao: SensorReadingDao,
    private val bluetoothClient: BluetoothClient
) {
    fun getReadingsForDevice(deviceId: String, since: String): Flow<List<SensorReading>> =
        dao.getReadingsSince(deviceId, since)

    suspend fun getLatestReading(deviceId: String): SensorReading? =
        dao.getLatestReading(deviceId)

    suspend fun syncReadingsFromDevice(deviceId: String, lastSyncedTimestamp: String?) {
        // Request readings from device via Bluetooth
        val newReadings = bluetoothClient.requestReadings(deviceId, lastSyncedTimestamp ?: "1970-01-01T00:00:00Z")
        // Insert into local database
        dao.insertAll(newReadings)
    }

    suspend fun getReadingsForChart(deviceId: String, startTime: String, endTime: String): List<SensorReading> =
        dao.getReadingsInRange(deviceId, startTime, endTime)
}

// DeviceRepository
class DeviceRepository(
    private val dao: DeviceDao,
    private val bluetoothClient: BluetoothClient
) {
    fun getAllDevices(): Flow<List<Device>> = dao.getAllDevices()

    suspend fun addDevice(device: Device) = dao.insertDevice(device)

    suspend fun updateDevice(device: Device) = dao.updateDevice(device)

    suspend fun getDevice(deviceId: String): Device? = dao.getDevice(deviceId)

    suspend fun updateLastSynced(deviceId: String, timestamp: String) {
        val device = dao.getDevice(deviceId)
        device?.let {
            dao.updateDevice(it.copy(lastSynced = timestamp))
        }
    }
}

// PlantRepository
class PlantRepository(private val plantDbService: PlantDatabaseService) {
    fun getAllPlants(): List<Plant> = plantDbService.getAllPlants()

    fun searchPlants(query: String): List<Plant> = plantDbService.searchPlants(query)

    fun getPlantsByCategory(category: String): List<Plant> = plantDbService.getPlantsByCategory(category)

    fun getPlantById(id: String): Plant? = plantDbService.getPlantById(id)
}
```

---

## Component 3: Bluetooth Client

**Purpose:** BLE communication with Raspberry Pi device for pairing, syncing, and configuration.

**Location:** `mobile-app/app/src/main/java/com/opengardenlab/bluetooth/`

**Key Operations:**

```kotlin
interface BluetoothClient {
    // Device discovery
    suspend fun scanForDevices(): List<BluetoothDevice>

    // Connection management
    suspend fun connect(deviceId: String): Boolean
    suspend fun disconnect(deviceId: String)

    // Data sync
    suspend fun requestReadings(deviceId: String, sinceTimestamp: String): List<SensorReading>
    suspend fun requestDeviceInfo(deviceId: String): DeviceInfo

    // Configuration
    suspend fun updateSamplingInterval(deviceId: String, intervalMinutes: Int): Boolean
    suspend fun requestCalibrationReading(deviceId: String, sensor: String): Double
    suspend fun saveCalibration(deviceId: String, airValue: Int, waterValue: Int): Boolean
}

// Implementation uses Android Bluetooth LE APIs
class BluetoothClientImpl(private val context: Context) : BluetoothClient {
    private val bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
    private val bluetoothAdapter = bluetoothManager.adapter

    override suspend fun scanForDevices(): List<BluetoothDevice> = withContext(Dispatchers.IO) {
        // Use BluetoothLeScanner to discover devices advertising OpenGardenLab service UUID
        // Return list of discovered devices
    }

    override suspend fun requestReadings(deviceId: String, sinceTimestamp: String): List<SensorReading> =
        withContext(Dispatchers.IO) {
            // 1. Connect to GATT server
            // 2. Write JSON request: {"type": "get_readings", "since": "2025-10-01T00:00:00Z"}
            // 3. Read JSON response: {"type": "readings", "data": [...]}
            // 4. Parse JSON to List<SensorReading>
            // 5. Disconnect
        }

    // Additional methods implemented similarly...
}
```

**Bluetooth Protocol** details deferred to Phase 5.

---

## Component 4: Recommendation Engine

**Purpose:** Compare sensor readings to plant optimal ranges and generate actionable recommendations.

**Location:** `mobile-app/app/src/main/java/com/opengardenlab/recommendations/`

```kotlin
data class Recommendation(
    val type: RecommendationType,
    val severity: Severity, // GOOD, CAUTION, ALERT
    val title: String,
    val description: String,
    val actionableSuggestion: String,
    val basedOnDays: Int // e.g., "Based on last 7 days of data"
)

enum class RecommendationType {
    SOIL_MOISTURE, LIGHT, AIR_TEMPERATURE, HUMIDITY
}

enum class Severity {
    GOOD, CAUTION, ALERT
}

class RecommendationEngine {
    fun generateRecommendations(
        readings: List<SensorReading>,
        plant: Plant?
    ): List<Recommendation> {
        if (plant == null) return emptyList()

        val recommendations = mutableListOf<Recommendation>()

        // Calculate averages over last 7 days
        val avgSoilMoisture = readings.map { it.soilMoisture }.average()
        val avgLightLux = readings.map { it.lightLux }.average()
        val avgAirTemp = readings.map { it.airTemp }.average()
        val avgHumidity = readings.map { it.airHumidity }.average()

        // Check soil moisture
        when {
            avgSoilMoisture < plant.soilMoisture.min -> {
                recommendations.add(Recommendation(
                    type = RecommendationType.SOIL_MOISTURE,
                    severity = Severity.ALERT,
                    title = "Soil is too dry",
                    description = "Average soil moisture is ${avgSoilMoisture.toInt()}%, but ${plant.commonName} prefers ${plant.soilMoisture.min.toInt()}-${plant.soilMoisture.max.toInt()}%.",
                    actionableSuggestion = "Water 1-2 cups daily until moisture reaches ${plant.soilMoisture.min.toInt()}-${plant.soilMoisture.max.toInt()}%.",
                    basedOnDays = 7
                ))
            }
            avgSoilMoisture > plant.soilMoisture.max -> {
                recommendations.add(Recommendation(
                    type = RecommendationType.SOIL_MOISTURE,
                    severity = Severity.CAUTION,
                    title = "Soil may be overwatered",
                    description = "Average soil moisture is ${avgSoilMoisture.toInt()}%, above optimal ${plant.soilMoisture.max.toInt()}%.",
                    actionableSuggestion = "Reduce watering frequency or improve drainage.",
                    basedOnDays = 7
                ))
            }
            else -> {
                recommendations.add(Recommendation(
                    type = RecommendationType.SOIL_MOISTURE,
                    severity = Severity.GOOD,
                    title = "Soil moisture is optimal",
                    description = "Moisture at ${avgSoilMoisture.toInt()}% (optimal: ${plant.soilMoisture.min.toInt()}-${plant.soilMoisture.max.toInt()}%).",
                    actionableSuggestion = "Keep current watering schedule.",
                    basedOnDays = 7
                ))
            }
        }

        // Check light (convert lux to estimated hours, simplified)
        val estimatedLightHours = calculateLightHours(readings)
        if (estimatedLightHours < plant.light.hoursPerDay) {
            recommendations.add(Recommendation(
                type = RecommendationType.LIGHT,
                severity = Severity.CAUTION,
                title = "Insufficient light",
                description = "Plant receiving ~${estimatedLightHours.toInt()} hours/day, needs ${plant.light.hoursPerDay.toInt()} hours.",
                actionableSuggestion = "Consider relocating to a sunnier spot or adding grow lights.",
                basedOnDays = 7
            ))
        }

        // Check air temperature
        if (avgAirTemp < plant.airTemp.minC || avgAirTemp > plant.airTemp.maxC) {
            val severity = if (avgAirTemp < plant.airTemp.minC - 5 || avgAirTemp > plant.airTemp.maxC + 5) {
                Severity.ALERT
            } else {
                Severity.CAUTION
            }
            recommendations.add(Recommendation(
                type = RecommendationType.AIR_TEMPERATURE,
                severity = severity,
                title = "Temperature outside optimal range",
                description = "Average temp ${avgAirTemp.toInt()}°C, optimal ${plant.airTemp.minC.toInt()}-${plant.airTemp.maxC.toInt()}°C.",
                actionableSuggestion = if (avgAirTemp < plant.airTemp.minC) {
                    "Provide frost protection or move indoors."
                } else {
                    "Provide shade or increase ventilation."
                },
                basedOnDays = 7
            ))
        }

        return recommendations
    }

    private fun calculateLightHours(readings: List<SensorReading>): Double {
        // Simplified: count readings where lux > threshold (e.g., 5000 lux = daylight)
        val daylightThreshold = 5000.0
        val daylightReadings = readings.count { it.lightLux > daylightThreshold }
        val totalReadings = readings.size
        val samplingIntervalHours = 0.25 // Assuming 15-minute intervals
        return (daylightReadings.toDouble() / totalReadings) * 24 // Rough estimate
    }
}
```

---

## Component 5: UI Layer (ViewModels + Screens)

**Purpose:** Display data, handle user interactions, manage UI state.

**Location:** `mobile-app/app/src/main/java/com/opengardenlab/ui/`

### Dashboard Screen

```kotlin
// DashboardViewModel
class DashboardViewModel(
    private val sensorRepo: SensorReadingRepository,
    private val deviceRepo: DeviceRepository,
    private val plantRepo: PlantRepository,
    private val recommendationEngine: RecommendationEngine
) : ViewModel() {

    private val _currentDevice = MutableLiveData<Device?>()
    val currentDevice: LiveData<Device?> = _currentDevice

    private val _latestReading = MutableLiveData<SensorReading?>()
    val latestReading: LiveData<SensorReading?> = _latestReading

    private val _assignedPlant = MutableLiveData<Plant?>()
    val assignedPlant: LiveData<Plant?> = _assignedPlant

    private val _recommendations = MutableLiveData<List<Recommendation>>()
    val recommendations: LiveData<List<Recommendation>> = _recommendations

    fun loadDashboard(deviceId: String) {
        viewModelScope.launch {
            // Load device
            val device = deviceRepo.getDevice(deviceId)
            _currentDevice.value = device

            // Load latest reading
            val reading = sensorRepo.getLatestReading(deviceId)
            _latestReading.value = reading

            // Load assigned plant
            device?.assignedPlantId?.let { plantId ->
                val plant = plantRepo.getPlantById(plantId)
                _assignedPlant.value = plant

                // Generate recommendations
                val last7Days = getReadingsLast7Days(deviceId)
                val recs = recommendationEngine.generateRecommendations(last7Days, plant)
                _recommendations.value = recs
            }
        }
    }

    fun syncDevice(deviceId: String) {
        viewModelScope.launch {
            try {
                val device = deviceRepo.getDevice(deviceId)
                sensorRepo.syncReadingsFromDevice(deviceId, device?.lastSynced)
                deviceRepo.updateLastSynced(deviceId, Clock.System.now().toString())
                loadDashboard(deviceId) // Refresh UI
            } catch (e: Exception) {
                // Handle sync error (show toast/snackbar)
            }
        }
    }

    private suspend fun getReadingsLast7Days(deviceId: String): List<SensorReading> {
        val now = Clock.System.now()
        val sevenDaysAgo = now.minus(7, DateTimeUnit.DAY)
        return sensorRepo.getReadingsForChart(deviceId, sevenDaysAgo.toString(), now.toString())
    }
}

// Dashboard UI (Jetpack Compose example)
@Composable
fun DashboardScreen(viewModel: DashboardViewModel, deviceId: String) {
    val device by viewModel.currentDevice.observeAsState()
    val reading by viewModel.latestReading.observeAsState()
    val plant by viewModel.assignedPlant.observeAsState()
    val recommendations by viewModel.recommendations.observeAsState(emptyList())

    LaunchedEffect(deviceId) {
        viewModel.loadDashboard(deviceId)
    }

    Column(modifier = Modifier.fillMaxSize().padding(16.dp)) {
        // Device name and sync button
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(text = device?.name ?: "Loading...", style = MaterialTheme.typography.h5)
            Spacer(modifier = Modifier.weight(1f))
            Button(onClick = { viewModel.syncDevice(deviceId) }) {
                Text("Sync")
            }
        }

        // Current sensor readings
        reading?.let { r ->
            Card(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp)) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text("Soil Moisture: ${r.soilMoisture.toInt()}%", style = MaterialTheme.typography.body1)
                    Text("Light: ${r.lightLux.toInt()} lux", style = MaterialTheme.typography.body1)
                    Text("Air Temp: ${r.airTemp.toInt()}°C", style = MaterialTheme.typography.body1)
                    Text("Humidity: ${r.airHumidity.toInt()}%", style = MaterialTheme.typography.body1)
                }
            }
        }

        // Assigned plant
        plant?.let { p ->
            Card(modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp)) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text("Assigned Plant: ${p.commonName}", style = MaterialTheme.typography.h6)
                    Text("Optimal Moisture: ${p.soilMoisture.min.toInt()}-${p.soilMoisture.max.toInt()}%")
                }
            }
        }

        // Top recommendations
        Text("Recommendations", style = MaterialTheme.typography.h6, modifier = Modifier.padding(top = 16.dp))
        recommendations.take(2).forEach { rec ->
            RecommendationCard(rec)
        }
    }
}
```

### Other Key Screens

- **Charts Screen** - Uses MPAndroidChart to display time-series data (line charts)
- **Plant Selection Screen** - Browse/search plant database, assign to device
- **Recommendations Screen** - Full list of recommendations with details
- **Settings Screen** - Configure sampling interval, run calibration wizard, view device info
- **Journal Screen** - Add notes, view chronological journal entries

---

## Navigation Architecture

**Kotlin (Jetpack Navigation):**

```kotlin
@Composable
fun OpenGardenLabNavigation() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = "device_list") {
        composable("device_list") { DeviceListScreen(navController) }
        composable("dashboard/{deviceId}") { backStackEntry ->
            DashboardScreen(
                deviceId = backStackEntry.arguments?.getString("deviceId") ?: "",
                navController = navController
            )
        }
        composable("charts/{deviceId}") { backStackEntry ->
            ChartsScreen(deviceId = backStackEntry.arguments?.getString("deviceId") ?: "")
        }
        composable("plant_selection/{deviceId}") { backStackEntry ->
            PlantSelectionScreen(deviceId = backStackEntry.arguments?.getString("deviceId") ?: "")
        }
        composable("settings/{deviceId}") { backStackEntry ->
            SettingsScreen(deviceId = backStackEntry.arguments?.getString("deviceId") ?: "")
        }
        composable("journal/{deviceId}") { backStackEntry ->
            JournalScreen(deviceId = backStackEntry.arguments?.getString("deviceId") ?: "")
        }
    }
}
```

---

**Phase 4 Complete.** This section defined the complete mobile app architecture: data layer (Room SQLite), repository pattern, Bluetooth client interface, recommendation engine logic, and UI layer with ViewModels and Compose screens.

---
