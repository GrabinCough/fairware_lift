plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    namespace = "com.fairware.fairware_lift.wear"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.fairware.fairware_lift.wear"
        minSdk = 30
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildFeatures {
        viewBinding = true
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    // Standard Android libraries
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")

    // --- NEW: Added ConstraintLayout for advanced UI positioning ---
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")

    // Wear OS specific libraries
    implementation("com.google.android.gms:play-services-wearable:18.2.0")
    implementation("androidx.wear:wear:1.3.0")
    implementation("androidx.activity:activity-ktx:1.9.0")

    // Lifecycle libraries for ViewModel and coroutines
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.8.3")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.8.3")

    // Health Services for heart rate monitoring (Phase 2)
    implementation("androidx.health:health-services-client:1.1.0-alpha03")
}