// ----- android\wear\src\main\kotlin\com\fairware\fairware_lift\wear\MainActivity.kt -----
package com.fairware.fairware_lift.wear

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.wear.compose.material.Text

class MainActivity : ComponentActivity() {

    private val TAG = "WearMainActivity"

    // UI state
    private var messageState = mutableStateOf("Ready")

    // Receiver that picks up messages forwarded by the service
    private val messageReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if (intent.action == DataLayerListenerService.ACTION_WEAR_MESSAGE) {
                val payload = intent.getStringExtra(DataLayerListenerService.EXTRA_MESSAGE) ?: ""
                val path = intent.getStringExtra(DataLayerListenerService.EXTRA_PATH) ?: ""
                Log.d(TAG, "Forwarded message received. path=$path payload=$payload")
                messageState.value = "Ping Received!"
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { WearApp(messageState.value) }
    }

    override fun onResume() {
        super.onResume()
        // Register to receive forwarded messages (no MessageClient listener here)
        registerReceiver(
            messageReceiver,
            IntentFilter(DataLayerListenerService.ACTION_WEAR_MESSAGE),
            RECEIVER_EXPORTED
        )
        Log.d(TAG, "Broadcast receiver registered.")
    }

    override fun onPause() {
        super.onPause()
        unregisterReceiver(messageReceiver)
        Log.d(TAG, "Broadcast receiver unregistered.")
    }
}

@Composable
fun WearApp(message: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.Black),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = message)
    }
}