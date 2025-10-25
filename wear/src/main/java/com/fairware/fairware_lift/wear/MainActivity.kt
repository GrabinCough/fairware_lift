package com.fairware.fairware_lift.wear

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class MainActivity : Activity() {

    private lateinit var textView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Create a simple TextView to display a message
        textView = TextView(this).apply {
            text = "Hello Wear OS!"
            textAlignment = TextView.TEXT_ALIGNMENT_CENTER
            textSize = 20f // Set a readable text size for the watch
        }

        // Set the TextView as the main content view for this activity
        setContentView(textView)
    }
}