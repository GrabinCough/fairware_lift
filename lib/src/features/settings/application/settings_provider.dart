// lib/src/features/settings/application/settings_provider.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Package for simple key-value storage.
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------------------------------------------------------
// --- CONSTANTS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

/// The key used to store the default rest duration in SharedPreferences.
const String _kDefaultRestDurationKey = 'defaultRestDuration';

/// The fallback rest duration in seconds if no preference is set.
const int kDefaultRestDuration = 90;

// -----------------------------------------------------------------------------
// --- SETTINGS STATE DATA MODEL -----------------------------------------------
// -----------------------------------------------------------------------------

/// An immutable class to hold all user-configurable settings.
class AppSettings {
  /// The user's preferred default rest time in seconds.
  final int defaultRestDuration;

  const AppSettings({
    this.defaultRestDuration = kDefaultRestDuration,
  });

  /// Creates a copy of the settings with some values replaced.
  AppSettings copyWith({
    int? defaultRestDuration,
  }) {
    return AppSettings(
      defaultRestDuration: defaultRestDuration ?? this.defaultRestDuration,
    );
  }
}

// -----------------------------------------------------------------------------
// --- SETTINGS NOTIFIER -------------------------------------------------------
// -----------------------------------------------------------------------------

/// A Riverpod Notifier that manages the state of the user's settings.
///
/// This class is responsible for loading settings from the device's local
/// storage and saving any changes back to it.
class SettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    // This method is called to provide the initial state.
    // It asynchronously loads the settings from SharedPreferences.
    return _loadSettings();
  }

  /// Loads the settings from SharedPreferences.
  Future<AppSettings> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final restDuration = prefs.getInt(_kDefaultRestDurationKey) ?? kDefaultRestDuration;
    return AppSettings(defaultRestDuration: restDuration);
  }

  /// Updates the user's default rest duration.
  ///
  /// This method saves the new value to SharedPreferences and then updates
  /// the in-memory state to reflect the change.
  Future<void> updateDefaultRestDuration(int newDuration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kDefaultRestDurationKey, newDuration);

    // Update the state with the new value.
    state = await AsyncValue.guard(() async {
      return state.value!.copyWith(defaultRestDuration: newDuration);
    });
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// The global provider for the user's settings.
///
/// The UI and other services will use this provider to access and modify
/// user preferences. Using an `AsyncNotifierProvider` handles the initial
/// asynchronous loading of the settings.
final settingsProvider = AsyncNotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);