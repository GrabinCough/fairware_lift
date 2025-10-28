// This file is intentionally left minimal.
// Top-level plugin versions are defined in settings.gradle.kts.
// Repository management is handled in settings.gradle.kts.

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}