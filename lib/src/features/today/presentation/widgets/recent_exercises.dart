// lib/src/features/today/presentation/widgets/recent_exercises.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
// --- NEW IMPORTS ---
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';
import 'package:fairware_lift/src/features/today/application/today_state.dart';

import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- RECENT EXERCISES WIDGET -------------------------------------------------
// -----------------------------------------------------------------------------

/// A widget to display a list or carousel of recently performed exercises.
/// This widget is now dynamic and fetches data from the `recentExercisesProvider`.
// --- REFACTORED ---
// Converted to a ConsumerWidget to watch the new provider.
class RecentExercises extends ConsumerWidget {
  const RecentExercises({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider that fetches recent exercises.
    final asyncRecentExercises = ref.watch(recentExercisesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Recent Exercises',
            style: AppTheme.typography.title,
          ),
        ),
        SizedBox(
          height: 120,
          // Use the .when() method to handle loading, error, and data states.
          child: asyncRecentExercises.when(
            // --- LOADING STATE ---
            loading: () => const Center(child: CircularProgressIndicator()),
            // --- ERROR STATE ---
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            // --- DATA STATE ---
            data: (exercises) {
              if (exercises.isEmpty) {
                return const Center(
                  child: Text('No recent exercises yet.'),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final recentExercise = exercises[index];
                  return _ExerciseCard(
                    // Pass the dynamic data to the card widget.
                    name: recentExercise.exercise.displayName,
                    lastSet:
                        '${recentExercise.lastSet.weight} lb x ${recentExercise.lastSet.reps}',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// --- PRIVATE EXERCISE CARD WIDGET --------------------------------------------
// -----------------------------------------------------------------------------

/// A private helper widget to define the appearance of a single exercise card.
/// This widget remains stateless as it just displays the data passed to it.
class _ExerciseCard extends StatelessWidget {
  final String name;
  final String lastSet;

  const _ExerciseCard({
    required this.name,
    required this.lastSet,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        color: AppTheme.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Allow up to 2 lines for longer names
              ),
              const Spacer(),
              Text(
                'Last Set:',
                style: AppTheme.typography.caption,
              ),
              const SizedBox(height: 4),
              Text(
                lastSet,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}