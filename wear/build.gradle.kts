plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("org.jetbrains.kotlin.plugin.compose") version "2.1.0"
}

android {
    // --- FIX: Namespace changed to match the phone app's package structure ---
    namespace = "com.example.fairware_lift"
    compileSdk = 35

    defaultConfig {
        // --- FIX: Application ID changed to match the phone app exactly ---
        applicationId = "com.example.fairware_lift"
        minSdk = 30
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    buildFeatures {
        compose = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    // ---- Jetpack Compose (BOM locks androidx.compose.* to a compatible family) ----
    val composeBom = platform("androidx.compose:compose-bom:2024.10.00")
    implementation(composeBom)
    androidTestImplementation(composeBom)

    // Core Compose
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")

    // Activity + Compose integration (SDK 35 compatible)
    implementation("androidx.activity:activity-compose:1.10.1")

    // ---- Wear Compose ----
    implementation("androidx.wear.compose:compose-foundation:1.5.4")
    implementation("androidx.wear.compose:compose-material3:1.5.4")
    implementation("androidx.wear.compose:compose-navigation:1.5.4")
    debugImplementation("androidx.wear.compose:compose-ui-tooling:1.5.4")

    // ---- Google Play services Wearable ----
    implementation("com.google.android.gms:play-services-wearable:19.0.0")

    // AndroidX core (SDK 35 / AGP 8.6+)
    implementation("androidx.core:core-ktx:1.16.0")

    // Tooling & tests
    debugImplementation("androidx.compose.ui:ui-tooling")
    debugImplementation("androidx.compose.ui:ui-test-manifest")
    androidTestImplementation("androidx.compose.ui:ui-test-junit4")
    androidTestImplementation("androidx.test.ext:junit:1.2.1")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.6.1")
    testImplementation("junit:junit:4.13.2")
}