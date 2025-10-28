plugins {
    id("com.android.application")
    // --- FIX: Added Firebase plugins back ---
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // --- FIX: Corrected Kotlin plugin ID ---
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // --- FIX: Restored correct namespace ---
    namespace = "com.fairware.fairware_lift"
    compileSdk = 35

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        // --- FIX: Restored correct application ID ---
        applicationId = "com.fairware.fairware_lift"
        // --- FIX: Set minSdk required by dependencies ---
        minSdk = 23
        targetSdk = 35
        versionCode = 1 // Flutter tool will override this from pubspec.yaml
        versionName = "1.0" // Flutter tool will override this from pubspec.yaml
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // --- FIX: Added necessary dependencies ---
    implementation(kotlin("stdlib"))
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}