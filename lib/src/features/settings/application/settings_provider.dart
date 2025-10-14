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

/// The key prefix used to store the quick rest timers in SharedPreferences.
const String _kQuickRestTimerKeyPrefix = 'quickRestTimer_';

/// The default values for the three quick-select timers in seconds.
const List<int> kDefaultQuickRestTimers = [60, 90, 180];

// -----------------------------------------------------------------------------
// --- SETTINGS STATE DATA MODEL -----------------------------------------------
// -----------------------------------------------------------------------------

/// An immutable class to hold all user-configurable settings.
class AppSettings {
  /// --- UPDATED ---
  /// A list of the user's three preferred quick-select rest times in seconds.
  final List<int> quickRestTimers;

  const AppSettings({
    this.quickRestTimers = kDefaultQuickRestTimers,
  });

  /// Creates a copy of the settings with some values replaced.
  AppSettings copyWith({
    List<int>? quickRestTimers,
  }) {
    return AppSettings(
      quickRestTimers: quickRestTimers ?? this.quickRestTimers,
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
    final timers = [
      prefs.getInt('${_kQuickRestTimerKeyPrefix}0') ?? kDefaultQuickRestTimers[0],
      prefs.getInt('${_kQuickRestTimerKeyPrefix}1') ?? kDefaultQuickRestTimers[1],
      prefs.getInt('${_kQuickRestTimerKeyPrefix}2') ?? kDefaultQuickRestTimers[2],
    ];
    return AppSettings(quickRestTimers: timers);
  }

  /// --- NEW METHOD ---
  /// Updates a specific quick rest timer at a given index.
  Future<void> updateQuickRestTimer({required int index, required int newDuration}) async {
    if (index < 0 || index > 2) return; // Guard against invalid index.

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_kQuickRestTimerKeyPrefix}$index', newDuration);

    // Update the state with the new list of timers.
    state = await AsyncValue.guard(() async {
      final currentTimers = List<int>.from(state.value!.quickRestTimers);
      currentTimers[index] = newDuration;
      return state.value!.copyWith(quickRestTimers: currentTimers);
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