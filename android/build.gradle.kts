// build.gradle.kts (top-level)

// FIX: Replaced incorrect Groovy 'ext' syntax with a valid Kotlin 'buildscript' block.
// This defines the Android Gradle Plugin and Kotlin versions for the entire project.
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.3.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.23")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}