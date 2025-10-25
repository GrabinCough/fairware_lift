plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    namespace = "com.fairware.fairware_lift.wear"
    compileSdk = 34 // Wear OS 4+ requires SDK 34

    defaultConfig {
        applicationId = "com.fairware.fairware_lift.wear"
        minSdk = 30 // Required for Wear OS 3 and Health Services
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildFeatures {
        // Enables easier access to layout views in code
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

    // Wear OS specific libraries
    implementation("com.google.android.gms:play-services-wearable:18.2.0")
    implementation("androidx.wear:wear:1.3.0")
    implementation("androidx.activity:activity-ktx:1.9.0")

    // Health Services for heart rate monitoring (Phase 2)
    implementation("androidx.health:health-services-client:1.1.0-alpha03")
}