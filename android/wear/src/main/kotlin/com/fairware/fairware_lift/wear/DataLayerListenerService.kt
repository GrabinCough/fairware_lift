// ----- android\wear\src\main\kotlin\com\fairware\fairware_lift\wear\DataLayerListenerService.kt -----
package com.fairware.fairware_lift.wear

import android.util.Log
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService

class DataLayerListenerService : WearableListenerService() {

    // Define a constant for logging
    private val TAG = "DataLayerListener"

    override fun onMessageReceived(messageEvent: MessageEvent) {
        super.onMessageReceived(messageEvent)

        // The watch_connectivity package sends messages to a default path.
        // We log the path to confirm, but we don't need to check for a specific one like "/ping".
        Log.d(TAG, "Message received on path: ${messageEvent.path}")

        // The data from watch_connectivity is a byte array containing a UTF-8 encoded string.
        // We decode it to see the content.
        val message = String(messageEvent.data, Charsets.UTF_8)
        Log.d(TAG, "Message payload: $message")
    }
}