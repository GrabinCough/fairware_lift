// lib/src/features/today/presentation/widgets/last_workout_preview.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/today/application/today_state.dart';

// -----------------------------------------------------------------------------
// --- LAST WORKOUT PREVIEW WIDGET ---------------------------------------------
// -----------------------------------------------------------------------------

class LastWorkoutPreview extends ConsumerWidget {
  const LastWorkoutPreview({super.key});

  /// --- UPDATED METHOD ---
  /// Infers a "Day Type" with added safety checks.
  String _inferDayType(List<String> familyIds) {
    if (familyIds.isEmpty) return 'Workout';

    final counts = familyIds.groupListsBy((id) => id);
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    if (sorted.isEmpty) return 'Workout';

    final mostCommon = sorted.first.key;
    final name = mostCommon.replaceAll('_', ' ').trim();

    // --- FIX: Add a guard to prevent RangeError on empty strings ---
    if (name.isEmpty) return 'Workout';

    return '${name[0].toUpperCase()}${name.substring(1)} Day';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLastWorkout = ref.watch(lastWorkoutProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Last Workout',
            style: AppTheme.typography.title,
          ),
        ),
        asyncLastWorkout.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (workout) {
            if (workout == null) {
              return Card(
                color: AppTheme.colors.surface,
                elevation: 0,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('No workouts logged yet.'),
                  ),
                ),
              );
            }

            final familyIds = workout.sets.map((s) => s.exercise.familyId).toList();
            final dayType = _inferDayType(familyIds);
            final formattedDate = DateFormat.yMMMMd().format(workout.session.sessionDateTime);

            return Card(
              color: AppTheme.colors.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayType,
                      style: AppTheme.typography.title.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDate,
                      style: AppTheme.typography.body.copyWith(color: AppTheme.colors.textMuted),
                    ),
                    const Divider(height: 24),
                    Text(
                      '${workout.sets.length} total sets performed.',
                      style: AppTheme.typography.body,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}