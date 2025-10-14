// lib/src/features/history/application/history_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';

// -----------------------------------------------------------------------------
// --- HISTORY STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

/// --- REFACTORED ---
/// This is now an AsyncNotifier, which allows us to manage an async state
/// that can be modified by UI interactions (like deleting an item).
class HistoryStateNotifier extends AsyncNotifier<List<FullWorkoutSession>> {
  /// The `build` method is called to provide the initial state. It fetches
  /// the complete workout history from the database.
  @override
  Future<List<FullWorkoutSession>> build() async {
    final db = ref.watch(databaseProvider);
    return db.getWorkoutHistory();
  }

  /// --- NEW METHOD ---
  /// Deletes a workout session from the database and then removes it from the
  /// current state, causing the UI to update automatically.
  Future<void> deleteWorkout(String sessionId) async {
    final db = ref.read(databaseProvider);

    // Perform the delete operation in the database.
    await db.deleteWorkoutSession(sessionId);

    // Update the in-memory state to reflect the deletion.
    // This avoids having to re-fetch the entire list from the database.
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? [];
      // Create a new list that excludes the deleted session.
      return currentState.where((workout) => workout.session.id != sessionId).toList();
    });
  }
}

// -----------------------------------------------------------------------------
// --- HISTORY STATE PROVIDER --------------------------------------------------
// -----------------------------------------------------------------------------

/// --- REFACTORED ---
/// The provider is now an `AsyncNotifierProvider`, which gives us an instance
/// of our `HistoryStateNotifier` and exposes its state.
final workoutHistoryProvider =
    AsyncNotifierProvider<HistoryStateNotifier, List<FullWorkoutSession>>(
  HistoryStateNotifier.new,
);