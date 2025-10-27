// ----- android\wear\src\main\kotlin\com\fairware\fairware_lift\wear\DataLayerListenerService.kt -----
package com.fairware.fairware_lift.wear

import android.content.Intent
import android.util.Log
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService

class DataLayerListenerService : WearableListenerService() {

    companion object {
        private const val TAG = "DataLayerListener"
        // Broadcast action + extra to forward messages to the UI
        const val ACTION_WEAR_MESSAGE = "com.fairware.fairware_lift.ACTION_WEAR_MESSAGE"
        const val EXTRA_MESSAGE = "extra_message"
        const val EXTRA_PATH = "extra_path"
    }

    override fun onMessageReceived(messageEvent: MessageEvent) {
        super.onMessageReceived(messageEvent)

        val path = messageEvent.path ?: ""
        val payload = try {
            String(messageEvent.data, Charsets.UTF_8)
        } catch (_: Throwable) {
            "<non-text payload (${messageEvent.data?.size ?: 0} bytes)>"
        }

        Log.d(TAG, "Message received. path=$path payload=$payload")

        // Forward to the Activity via a broadcast so UI can update if it's visible
        val intent = Intent(ACTION_WEAR_MESSAGE).apply {
            putExtra(EXTRA_MESSAGE, payload)
            putExtra(EXTRA_PATH, path)
        }
        sendBroadcast(intent)
    }
}