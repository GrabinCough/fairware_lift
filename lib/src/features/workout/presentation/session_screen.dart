// ----- lib/src/features/workout/presentation/session_screen.dart -----
// lib/src/features/workout/presentation/session_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/exercises/data/presentation/exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/exercises/domain/exercise.dart' as lib_exercise;
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/exercise_list_item.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/warmup_list_item.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/workout_dock.dart';
import 'package:fairware_lift/src/features/workout/presentation/workout_summary_screen.dart';
import 'package:fairware_lift/src/features/workout_import/presentation/paste_workout_screen.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});
  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(workoutMetricsProvider.notifier).startWorkout();
    });
  }

  @override
  void dispose() {
    ref.read(workoutMetricsProvider.notifier).stopWorkout();
    super.dispose();
  }

  void _showExerciseInfoSheet(BuildContext context, SessionExercise exercise) {
    final info = exercise.info;
    if (info == null) {
      _showSimpleInfoDialog(context, exercise.displayName, 'No additional information available for this exercise.');
    } else if (info.howTo != null && info.coachingCues == null && info.videoSearchQuery == null) {
      _showSimpleInfoDialog(context, exercise.displayName, info.howTo!);
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, controller) => _ExerciseInfoSheet(controller: controller, info: info, exerciseName: exercise.displayName),
        ),
      );
    }
  }

  void _showSimpleInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.colors.surface,
        title: Text(title),
        content: Text(content, style: AppTheme.typography.body),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
      ),
    );
  }

  Future<bool?> _showDeleteItemConfirmationDialog(BuildContext context, {String itemType = 'Item'}) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: Text('Delete $itemType?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Delete',
                style: TextStyle(color: AppTheme.colors.danger),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final sessionItems = ref.watch(sessionStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Workout'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(workoutMetricsProvider.notifier).stopWorkout();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WorkoutSummaryScreen(completedItems: ref.read(sessionStateProvider)),
              ));
            },
            child: const Text('Finish'),
          ),
        ],
      ),
      // --- MODIFIED: Removed the FloatingActionButton ---
      bottomNavigationBar: const WorkoutDock(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 150),
          children: [
            if (sessionItems.isEmpty) _buildEmptyState(context)
            else ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) => ref.read(sessionStateProvider.notifier).reorderItem(oldIndex, newIndex),
              children: sessionItems.map((item) {
                return switch (item) {
                  SessionExercise e => Dismissible(
                      key: ValueKey(item.id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) => _showDeleteItemConfirmationDialog(context, itemType: 'Exercise'),
                      onDismissed: (_) => ref.read(sessionStateProvider.notifier).deleteItem(item.id),
                      background: _buildDismissBackground(),
                      child: ExerciseListItem(
                        displayName: e.displayName,
                        prescription: e.prescription,
                        variation: e.variation,
                        loggedSets: e.loggedSets,
                        isCurrent: e.isCurrent,
                        onCardTap: () => ref.read(sessionStateProvider.notifier).setCurrentItem(itemId: e.id),
                        onInfoTap: () => _showExerciseInfoSheet(context, e),
                        setType: e.defaultSetType,
                      ),
                    ),
                  SessionWarmupItem w => Dismissible(
                      key: ValueKey(item.id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) => _showDeleteItemConfirmationDialog(context, itemType: 'Warmup'),
                      onDismissed: (_) => ref.read(sessionStateProvider.notifier).deleteItem(item.id),
                      background: _buildDismissBackground(),
                      child: WarmupListItem(warmup: w),
                    ),
                  SessionSuperset s => _SupersetListItem(
                      key: ValueKey(item.id),
                      superset: s,
                      onInfoTap: (exercise) => _showExerciseInfoSheet(context, exercise),
                      onDeleteConfirm: _showDeleteItemConfirmationDialog,
                    ),
                };
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDismissBackground() => Container(
    color: AppTheme.colors.danger,
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: const Icon(Icons.delete_forever_rounded, color: Colors.white),
  );

  Widget _buildEmptyState(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Column(
        children: [
          Icon(Icons.directions_run_rounded, size: 64, color: AppTheme.colors.textMuted),
          const SizedBox(height: 16),
          Text('Your session is empty.', style: AppTheme.typography.title),
          const SizedBox(height: 8),
          Text('Import a workout or add an exercise to get started.', style: AppTheme.typography.body, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(fullscreenDialog: true, builder: (context) => const PasteWorkoutScreen())),
            icon: const Icon(Icons.paste_rounded),
            label: const Text('Import from Text'),
          ),
        ],
      ),
    ),
  );
}

class _SupersetListItem extends ConsumerWidget {
  final SessionSuperset superset;
  final void Function(SessionExercise) onInfoTap;
  final Future<bool?> Function(BuildContext, {String itemType}) onDeleteConfirm;

  const _SupersetListItem({
    super.key, 
    required this.superset, 
    required this.onInfoTap,
    required this.onDeleteConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      key: key,
      color: AppTheme.colors.surface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        side: BorderSide(color: AppTheme.colors.surfaceAlt, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.link_rounded, color: AppTheme.colors.textMuted),
              title: Text('Superset', style: AppTheme.typography.body.copyWith(color: AppTheme.colors.textMuted)),
              dense: true,
            ),
            ...superset.exercises.map((exercise) => Dismissible(
              key: ValueKey(exercise.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) => onDeleteConfirm(context, itemType: 'Exercise'),
              onDismissed: (_) => ref.read(sessionStateProvider.notifier).deleteExerciseFromSuperset(supersetId: superset.id, exerciseId: exercise.id),
              background: Container(color: AppTheme.colors.danger, alignment: Alignment.centerRight, padding: const EdgeInsets.symmetric(horizontal: 20.0), child: const Icon(Icons.delete_forever_rounded, color: Colors.white)),
              child: ExerciseListItem(
                displayName: exercise.displayName,
                prescription: exercise.prescription,
                variation: exercise.variation,
                loggedSets: exercise.loggedSets,
                isCurrent: exercise.isCurrent,
                onCardTap: () => ref.read(sessionStateProvider.notifier).setCurrentItem(itemId: exercise.id),
                onInfoTap: () => onInfoTap(exercise),
                setType: exercise.defaultSetType,
              ),
            )),
          ],
        ),
      ),
    );
  }
}


class _ExerciseInfoSheet extends StatelessWidget {
  final ScrollController controller;
  final Info info;
  final String exerciseName;
  const _ExerciseInfoSheet({required this.controller, required this.info, required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        controller: controller,
        padding: const EdgeInsets.all(24),
        children: [
          Text(exerciseName, style: AppTheme.typography.display.copyWith(fontSize: 28)),
          const SizedBox(height: 24),
          if (info.howTo != null) _buildSection('How To', Text(info.howTo!, style: AppTheme.typography.body)),
          if (info.coachingCues?.isNotEmpty ?? false) _buildSection('Coaching Cues', _buildBulletList(info.coachingCues!)),
          if (info.commonErrors?.isNotEmpty ?? false) _buildSection('Common Errors', _buildBulletList(info.commonErrors!)),
          if (info.safetyNotes != null) _buildSection('Safety', Text(info.safetyNotes!, style: AppTheme.typography.body)),
          if (info.progression != null) _buildSection('Progression', Text(info.progression!, style: AppTheme.typography.body)),
          if (info.regression != null) _buildSection('Regression', Text(info.regression!, style: AppTheme.typography.body)),
          if (info.equipmentNotes != null) _buildSection('Equipment', Text(info.equipmentNotes!, style: AppTheme.typography.body)),
          const SizedBox(height: 24),
          Row(
            children: [
              if (info.videoSearchQuery != null) Expanded(child: _buildSearchButton(icon: Icons.video_library_rounded, label: 'Search Video', query: info.videoSearchQuery!, isVideo: true)),
              if (info.videoSearchQuery != null && info.webSearchQuery != null) const SizedBox(width: 16),
              if (info.webSearchQuery != null) Expanded(child: _buildSearchButton(icon: Icons.search, label: 'Search Web', query: info.webSearchQuery!)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTheme.typography.title),
      const SizedBox(height: 8),
      content,
      const SizedBox(height: 24),
    ],
  );

  Widget _buildBulletList(List<String> items) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(item, style: AppTheme.typography.body)),
        ],
      ),
    )).toList(),
  );

  Widget _buildSearchButton({required IconData icon, required String label, required String query, bool isVideo = false}) {
    return ElevatedButton.icon(
      onPressed: () async {
        final url = isVideo
            ? Uri.https('youtube.com', '/results', {'search_query': query})
            : Uri.https('google.com', '/search', {'q': query});
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }
}