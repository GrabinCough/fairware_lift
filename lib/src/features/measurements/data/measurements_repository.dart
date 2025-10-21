// lib/src/features/measurements/data/measurements_repository.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------------------------------------------------------
// --- CONSTANTS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

const String _kLatestBodyweightKey = 'latest_bodyweight_lbs';

// -----------------------------------------------------------------------------
// --- MEASUREMENTS REPOSITORY -------------------------------------------------
// -----------------------------------------------------------------------------

/// A repository for saving and retrieving user measurement data.
class MeasurementsRepository {
  final SharedPreferences _prefs;

  MeasurementsRepository(this._prefs);

  /// Saves the user's most recent bodyweight.
  Future<void> saveLatestBodyweight(double weightLbs) async {
    await _prefs.setDouble(_kLatestBodyweightKey, weightLbs);
  }

  /// Retrieves the user's most recent bodyweight.
  double? getLatestBodyweight() {
    return _prefs.getDouble(_kLatestBodyweightKey);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDERS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

/// Provider for SharedPreferences, used by other providers in this file.
final _sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());

/// Provider for the MeasurementsRepository.
final measurementsRepositoryProvider = Provider<MeasurementsRepository>((ref) {
  final prefs = ref.watch(_sharedPreferencesProvider).value;
  if (prefs == null) {
    throw Exception('SharedPreferences not initialized for MeasurementsRepository');
  }
  return MeasurementsRepository(prefs);
});

/// A simple StateProvider to hold the latest bodyweight, allowing the UI to
/// reactively update when a new measurement is saved.
final latestBodyweightProvider = StateProvider<double?>((ref) {
  return ref.watch(measurementsRepositoryProvider).getLatestBodyweight();
});