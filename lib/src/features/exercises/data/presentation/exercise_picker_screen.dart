// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// --- THIS IS THE CORRECTED IMPORT ---
// The path now correctly goes up one level from 'presentation' to find the
// mock repository in the 'data' directory.
import '../mock_exercise_repository.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE PICKER SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

/// A screen that displays a searchable list of exercises for the user to select.
class ExercisePickerScreen extends ConsumerWidget {
  const ExercisePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the list of exercises from our repository provider.
    final exercises = ref.watch(exerciseRepositoryProvider).getExercises();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exercise'),
        backgroundColor: AppTheme.colors.surface,
      ),
      body: Column(
        children: [
          // --- SEARCH BAR (Placeholder) ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
                  borderSide: BorderSide.none,
                ),
              ),
              // TODO: Implement search functionality.
            ),
          ),

          // --- EXERCISE LIST ---
          // The list is wrapped in an Expanded widget to make it fill the
          // remaining vertical space.
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return ListTile(
                  title: Text(exercise.name),
                  onTap: () {
                    // When an exercise is tapped, pop the screen and return
                    // the selected exercise object to the caller.
                    Navigator.of(context).pop(exercise);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}