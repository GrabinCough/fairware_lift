plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.fairware.fairware_lift"
    compileSdk = 35

    compileOptions {
        // --- FIX: Updated to Java 17 for modern Android compatibility. ---
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        // --- FIX: Aligned Kotlin's JVM target to 17. ---
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.fairware.fairware_lift"
        minSdk = 23
        targetSdk = 35
        versionCode = 1 // Flutter tool will override this from pubspec.yaml
        versionName = "1.0" // Flutter tool will override this from pubspec.yaml
    }

    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(kotlin("stdlib"))
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}