// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The session state provider (our app's "brain").
import '../application/session_state.dart';

// The widgets for this screen.
import 'widgets/workout_dock.dart';
import 'widgets/exercise_list_item.dart';

// -----------------------------------------------------------------------------
// --- SESSION SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// The full-screen UI for an active workout session.
///
/// This is a ConsumerWidget, which means it can listen to Riverpod providers.
/// It will automatically rebuild whenever the session state changes.
class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- STATE INTEGRATION ---
    // We are now "watching" the sessionStateProvider. `ref.watch` gets the
    // current state (the list of exercises) and subscribes to any future changes.
    final sessionExercises = ref.watch(sessionStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Push Day - Block A'), // Placeholder
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Finish',
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const WorkoutDock(),
      // The body now uses a ListView.builder to efficiently create the list.
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
        // The number of items in the list is the length of our state list.
        itemCount: sessionExercises.length,
        // The builder function is called for each item in the list.
        itemBuilder: (context, index) {
          // Get the specific exercise for this list item.
          final exercise = sessionExercises[index];
          // --- STATE INTEGRATION ---
          // We pass the dynamic data from our state down to the
          // ExerciseListItem widget.
          return ExerciseListItem(
            exerciseName: exercise.name,
            target: exercise.target,
            loggedSets: exercise.loggedSets,
            isCurrent: exercise.isCurrent,
          );
        },
      ),
    );
  }
}