// ----- lib/src/features/workout/presentation/widgets/reps_only_set_sheet.dart -----
// lib/src/features/workout/presentation/widgets/reps_only_set_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/measurements/data/measurements_repository.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// -----------------------------------------------------------------------------
// --- REPS ONLY SET SHEET WIDGET ----------------------------------------------
// -----------------------------------------------------------------------------

class RepsOnlySetSheet extends ConsumerStatefulWidget {
  // --- NEW: Accept an optional set to edit ---
  final LoggedSet? set;

  const RepsOnlySetSheet({super.key, this.set});

  @override
  ConsumerState<RepsOnlySetSheet> createState() => _RepsOnlySetSheetState();
}

class _RepsOnlySetSheetState extends ConsumerState<RepsOnlySetSheet> {
  final _repsController = TextEditingController();

  // --- NEW: Pre-fill controller if editing ---
  @override
  void initState() {
    super.initState();
    if (widget.set != null) {
      _repsController.text = widget.set!.reps?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _repsController.dispose();
    super.dispose();
  }

  void _onLogSet() {
    final reps = int.tryParse(_repsController.text) ?? 0;

    if (mounted) {
      // --- MODIFIED: Handle both add and edit cases ---
      if (widget.set != null) {
        // When editing, just return the ID and new reps.
        Navigator.of(context).pop({'id': widget.set!.id, 'reps': reps});
      } else {
        // When adding, get the current bodyweight and return it.
        final bodyweight = ref.read(latestBodyweightProvider) ?? 0.0;
        Navigator.of(context).pop({'reps': reps, 'weight': bodyweight});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncRepo = ref.watch(measurementsRepositoryProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: asyncRepo.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _repsController,
                label: 'Reps',
                autofocus: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onLogSet,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save Set'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool autofocus = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: AppTheme.typography.number,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.typography.body,
        filled: true,
        fillColor: AppTheme.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}