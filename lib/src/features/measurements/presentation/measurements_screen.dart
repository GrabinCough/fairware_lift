// lib/src/features/measurements/presentation/measurements_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/measurements/data/measurements_repository.dart';
import 'package:fairware_lift/src/features/measurements/presentation/add_measurement_sheet.dart';

// -----------------------------------------------------------------------------
// --- MEASUREMENTS SCREEN WIDGET ----------------------------------------------
// -----------------------------------------------------------------------------

class MeasurementsScreen extends ConsumerWidget {
  const MeasurementsScreen({super.key});

  void _showAddMeasurementSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.colors.surface,
      builder: (context) => const AddMeasurementSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestWeight = ref.watch(latestBodyweightProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.sizing.baseGrid * 4, // 32pt
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monitor_weight_rounded,
                size: 80,
                color: AppTheme.colors.textMuted,
              ),
              const SizedBox(height: 24),
              // --- MODIFIED: Conditional UI ---
              if (latestWeight == null)
                Text(
                  'No measurements yet.',
                  style: AppTheme.typography.title.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                Text(
                  'Latest Weight: ${latestWeight.toStringAsFixed(1)} lbs',
                  style: AppTheme.typography.title.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _showAddMeasurementSheet(context),
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: Text(latestWeight == null
                    ? 'Add Measurement'
                    : 'Update Measurement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}