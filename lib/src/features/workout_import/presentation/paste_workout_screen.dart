// lib/src/features/workout_import/presentation/paste_workout_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout_import/application/lift_importer.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/presentation/session_screen.dart';

// -----------------------------------------------------------------------------
// --- LOCAL STATE PROVIDERS ---------------------------------------------------
// -----------------------------------------------------------------------------

final _importStateProvider = StateProvider<AsyncValue<void>>((ref) => const AsyncData(null));

// -----------------------------------------------------------------------------
// --- PASTE WORKOUT SCREEN WIDGET ---------------------------------------------
// -----------------------------------------------------------------------------

class PasteWorkoutScreen extends ConsumerStatefulWidget {
  const PasteWorkoutScreen({super.key});

  @override
  ConsumerState<PasteWorkoutScreen> createState() => _PasteWorkoutScreenState();
}

class _PasteWorkoutScreenState extends ConsumerState<PasteWorkoutScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleImport() async {
    // --- FIX ---
    // We now read the FutureProvider for the importer.
    final importer = await ref.read(liftImporterProvider.future);
    final notifier = ref.read(_importStateProvider.notifier);
    
    notifier.state = const AsyncLoading();

    final output = await importer.importFromJson(_textController.text);

    if (!mounted) return;

    if (output.hasError) {
      notifier.state = AsyncError(output.error!, StackTrace.current);
    } else if (output.hasIssues) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${output.issues.length} exercises could not be matched and will be unmapped.'),
          backgroundColor: AppTheme.colors.warning,
        ),
      );
      
      ref.read(sessionStateProvider.notifier).importWorkout(output.sessionItems);
      _navigateToSession();
    } else {
      ref.read(sessionStateProvider.notifier).importWorkout(output.sessionItems);
      _navigateToSession();
    }
  }

  void _navigateToSession() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const SessionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final importState = ref.watch(_importStateProvider);
    // --- FIX ---
    // We watch the async provider to show a loading state while the matcher initializes.
    final asyncImporter = ref.watch(liftImporterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Workout'),
        backgroundColor: AppTheme.colors.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: asyncImporter.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error initializing importer: $err')),
          data: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Paste the JSON output from your LLM below. The app will build the workout cards for you.',
                style: AppTheme.typography.body,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _textController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  style: AppTheme.typography.body.copyWith(fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: '{\n  "version": "lift.v1",\n  ...\n}',
                    filled: true,
                    fillColor: AppTheme.colors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
                      borderSide: BorderSide.none,
                    ),
                    errorText: importState.whenOrNull(error: (e, s) => e.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: importState.isLoading ? null : _handleImport,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: importState.isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Preview & Build Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}