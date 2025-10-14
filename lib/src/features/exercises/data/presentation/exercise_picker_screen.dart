// lib/src/features/exercises/data/presentation/exercise_picker_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// --- FIX ---
// These imports now use the full package path, which is the most reliable
// way to ensure the files are found by the compiler.
import 'package:fairware_lift/src/features/exercises/data/exercise_repository.dart';
import 'package:fairware_lift/src/features/exercises/domain/exercise.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE PICKER SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

/// A screen that displays a searchable list of exercises for the user to select.
/// This is now a stateful widget to manage the search query.
class ExercisePickerScreen extends ConsumerStatefulWidget {
  const ExercisePickerScreen({super.key});

  @override
  ConsumerState<ExercisePickerScreen> createState() => _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends ConsumerState<ExercisePickerScreen> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Update the search query whenever the text in the search bar changes.
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Shows an AlertDialog with the exercise's "how-to" instructions.
  void _showExerciseInfo(BuildContext context, Exercise exercise) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: Text(exercise.name),
          content: Text(exercise.howTo),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the FutureProvider for the exercise repository.
    final exerciseRepoAsync = ref.watch(exerciseRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exercise'),
        backgroundColor: AppTheme.colors.surface,
      ),
      body: Column(
        children: [
          // --- SEARCH BAR ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
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
            ),
          ),

          // --- EXERCISE LIST ---
          // Handle the different states of the FutureProvider.
          Expanded(
            child: exerciseRepoAsync.when(
              // --- DATA LOADED STATE ---
              data: (repo) {
                // Filter the full list based on the current search query.
                final allExercises = repo.getAllExercises();
                final filteredExercises = allExercises.where((exercise) {
                  return exercise.name
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  itemCount: filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
                    return ListTile(
                      title: Text(exercise.name),
                      // --- NEW INFO BUTTON ---
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline_rounded),
                        onPressed: () => _showExerciseInfo(context, exercise),
                      ),
                      onTap: () {
                        // Return the selected exercise to the previous screen.
                        Navigator.of(context).pop(exercise);
                      },
                    );
                  },
                );
              },
              // --- LOADING STATE ---
              loading: () => const Center(child: CircularProgressIndicator()),
              // --- ERROR STATE ---
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}