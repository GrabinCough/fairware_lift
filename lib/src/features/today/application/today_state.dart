// lib/src/features/today/application/today_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';

// -----------------------------------------------------------------------------
// --- STATE NOTIFIER ----------------------------------------------------------
// -----------------------------------------------------------------------------

/// An AsyncNotifier responsible for fetching and providing the state for the
/// "Today" screen, starting with the list of recently performed exercises.
class TodayStateNotifier extends AsyncNotifier<List<RecentExercise>> {
  /// The `build` method is called to provide the initial state. It fetches
  /// the recent exercises from the database.
  @override
  Future<List<RecentExercise>> build() async {
    final db = ref.watch(databaseProvider);
    // Fetch the 5 most recently used exercises.
    return db.getRecentExercises(limit: 5);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A provider that exposes the list of recent exercises. The UI will watch this
/// provider to dynamically display the user's recent activity.
final recentExercisesProvider =
    AsyncNotifierProvider<TodayStateNotifier, List<RecentExercise>>(
  TodayStateNotifier.new,
);