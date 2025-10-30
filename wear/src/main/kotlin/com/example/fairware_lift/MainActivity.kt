// --- FIX: Package declaration updated to match the new file path ---
package com.example.fairware_lift

import android.net.Uri
import android.os.Bundle
import android.util.Log
// --- NEW: Import Toast for showing notifications ---
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Text
import com.google.android.gms.wearable.*
import org.json.JSONObject

// A simple singleton object to hold the timer state in memory.
object TimerRepository {
    private val _seconds = mutableStateOf(0)
    private val _running = mutableStateOf(false)

    val seconds: State<Int> = _seconds
    val running: State<Boolean> = _running

    fun updateFromJson(json: String) {
        try {
            val map = JSONObject(json)
            _seconds.value = map.optInt("seconds", 0)
            _running.value = map.optBoolean("isRunning", false)
        } catch (e: Exception) {
            // Ignore malformed JSON
        }
    }

    fun updateFromDataMap(map: DataMap) {
        if (map.containsKey("seconds")) {
            _seconds.value = map.getInt("seconds")
        }
        if (map.containsKey("isRunning")) {
            _running.value = map.getBoolean("isRunning")
        }
    }
}

class MainActivity : ComponentActivity() {

    private val TAG = "FairwareLiftWear"

    private val messageClient by lazy { Wearable.getMessageClient(this) }
    private val dataClient by lazy { Wearable.getDataClient(this) }

    // Listener for high-frequency messages (for live updates)
    private val messageListener = MessageClient.OnMessageReceivedListener { event ->
        Log.d(TAG, "Message received on path: ${event.path}")
        if (event.path.startsWith("/timer")) {
            val jsonString = String(event.data)
            Log.d(TAG, "Payload: $jsonString")

            // --- NEW: Handle different message types ---
            try {
                val json = JSONObject(jsonString)
                if (json.optString("type") == "ping") {
                    // This is a simple ping. Show a Toast message for feedback.
                    runOnUiThread {
                        Toast.makeText(this, "Ping Received!", Toast.LENGTH_SHORT).show()
                    }
                } else {
                    // This is a regular timer state update.
                    TimerRepository.updateFromJson(jsonString)
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error parsing message JSON", e)
            }
        }
    }

    // Listener for persistent data items (for state recovery)
    private val dataListener = DataClient.OnDataChangedListener { events ->
        Log.d(TAG, "Data changed event received.")
        for (event in events) {
            if (event.type == DataEvent.TYPE_CHANGED && event.dataItem.uri.path?.startsWith("/timer") == true) {
                val dataMap = DataMapItem.fromDataItem(event.dataItem).dataMap
                Log.d(TAG, "DataMap updated: $dataMap")
                TimerRepository.updateFromDataMap(dataMap)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TimerScreen()
        }
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "Attaching Wearable listeners...")
        // Register listeners when the app is in the foreground
        messageClient.addListener(
            messageListener,
            Uri.parse("wear://*/timer"),
            MessageClient.FILTER_PREFIX
        )
        dataClient.addListener(dataListener)
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "Removing Wearable listeners.")
        // Unregister listeners to save battery when the app is not visible
        messageClient.removeListener(messageListener)
        dataClient.removeListener(dataListener)
    }
}

@Composable
fun TimerScreen() {
    val seconds by TimerRepository.seconds
    val running by TimerRepository.running

    MaterialTheme {
        Column(
            modifier = Modifier.fillMaxSize().padding(12.dp),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = if (running) "Resting..." else "Timer Paused",
                style = MaterialTheme.typography.title3.copy(fontWeight = FontWeight.SemiBold)
            )
            Spacer(Modifier.height(8.dp))
            Text(
                text = "${seconds}s",
                style = MaterialTheme.typography.display1
            )
        }
    }
}

@Preview(showBackground = true, device = "id:wearos_small_round")
@Composable
fun TimerScreenPreview() {
    TimerScreen()
}