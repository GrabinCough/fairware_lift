// lib/src/features/today/application/today_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';

// -----------------------------------------------------------------------------
// --- STATE NOTIFIER ----------------------------------------------------------
// -----------------------------------------------------------------------------

/// --- REFACTORED ---
/// This notifier now fetches the single most recent `FullWorkoutSession`.
class LastWorkoutNotifier extends AsyncNotifier<FullWorkoutSession?> {
  @override
  Future<FullWorkoutSession?> build() async {
    final db = ref.watch(databaseProvider);
    return db.getLatestWorkout();
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// --- REFACTORED ---
/// A provider that exposes the last workout session for the Today screen preview.
final lastWorkoutProvider =
    AsyncNotifierProvider<LastWorkoutNotifier, FullWorkoutSession?>(
  LastWorkoutNotifier.new,
);