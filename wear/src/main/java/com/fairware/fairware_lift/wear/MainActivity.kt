package com.fairware.fairware_lift.wear

import android.Manifest
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.health.services.client.HealthServices
import androidx.health.services.client.HealthServicesClient
import androidx.health.services.client.MeasureCallback
import androidx.health.services.client.data.Availability
import androidx.health.services.client.data.DataType
import androidx.health.services.client.data.DataPointContainer
import androidx.health.services.client.data.DeltaDataType
import androidx.health.services.client.data.DataTypeAvailability
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.lifecycle.lifecycleScope
import com.fairware.fairware_lift.wear.databinding.ActivityMainBinding
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import android.os.CountDownTimer

// --- VIEWMODEL ---
class TimerViewModel : ViewModel() {
    private val _uiState = MutableStateFlow(UiState())
    val uiState: StateFlow<UiState> = _uiState

    private var countDownTimer: CountDownTimer? = null
    private var measureCallback: MeasureCallback? = null

    fun startTimer() {
        if (countDownTimer != null) return
        countDownTimer = object : CountDownTimer((_uiState.value.secondsRemaining * 1000).toLong(), 1000) {
            override fun onTick(millisUntilFinished: Long) {
                _uiState.value = _uiState.value.copy(
                    secondsRemaining = (millisUntilFinished / 1000).toInt()
                )
            }
            override fun onFinish() {
                _uiState.value = _uiState.value.copy(secondsRemaining = 0)
            }
        }.start()
    }

    fun startHeartRateMonitoring(healthServicesClient: HealthServicesClient) {
        val measureClient = healthServicesClient.measureClient

        measureCallback = object : MeasureCallback {
            override fun onAvailabilityChanged(
                dataType: DeltaDataType<*, *>,
                availability: Availability
            ) {
                viewModelScope.launch {
                    val isAvailable =
                        (availability as? DataTypeAvailability) == DataTypeAvailability.AVAILABLE
                    _uiState.value = _uiState.value.copy(hrSensorAvailable = isAvailable)
                    Log.d("WearHR", "Sensor availability changed: $isAvailable")
                }
            }

            override fun onDataReceived(data: DataPointContainer) {
                val heartRateBpm = data.getData(DataType.HEART_RATE_BPM).firstOrNull()?.value
                if (heartRateBpm != null) {
                    viewModelScope.launch {
                        _uiState.value = _uiState.value.copy(currentHr = heartRateBpm.toInt())
                    }
                }
            }
        }

        viewModelScope.launch {
            try {
                measureClient.registerMeasureCallback(DataType.HEART_RATE_BPM, measureCallback!!)
                Log.d("WearHR", "HR callback registration attempted.")
            } catch (e: Exception) {
                Log.e("WearHR", "Error registering HR callback", e)
            }
        }
    }

    override fun onCleared() {
        super.onCleared()
        countDownTimer?.cancel()
    }
}

// --- UI STATE DATA CLASS ---
data class UiState(
    val secondsRemaining: Int = 90,
    val totalDuration: Int = 90,
    val currentHr: Int? = null,
    val hrSensorAvailable: Boolean = true,
    val permissionGranted: Boolean = false
)

// --- MAIN ACTIVITY ---
class MainActivity : ComponentActivity() {

    private lateinit var binding: ActivityMainBinding
    private val viewModel: TimerViewModel by viewModels()
    private val healthServicesClient by lazy { HealthServices.getClient(this) }

    private val permissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { isGranted ->
        if (isGranted) {
            Log.d("WearHR", "BODY_SENSORS permission granted.")
            viewModel.startHeartRateMonitoring(healthServicesClient)
        } else {
            Log.d("WearHR", "BODY_SENSORS permission denied.")
            binding.hrText.text = "Permission Denied"
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        lifecycleScope.launch {
            viewModel.uiState.collect { state ->
                updateUi(state)
            }
        }

        viewModel.startTimer()
        permissionLauncher.launch(Manifest.permission.BODY_SENSORS)
    }

    private fun updateUi(state: UiState) {
        val minutes = state.secondsRemaining / 60
        val seconds = state.secondsRemaining % 60
        binding.timerText.text = String.format("%d:%02d", minutes, seconds)

        if (state.totalDuration > 0) {
            binding.progressBar.progress = (state.secondsRemaining * 100 / state.totalDuration)
        } else {
            binding.progressBar.progress = 0
        }

        when {
            state.currentHr != null -> binding.hrText.text = "${state.currentHr} bpm"
            !state.hrSensorAvailable -> binding.hrText.text = "Sensor Unavailable"
            else -> binding.hrText.text = "-- bpm"
        }
    }
}