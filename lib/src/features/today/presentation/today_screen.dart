// ----- lib\src\features\today\presentation\today_screen.dart -----
// lib/src/features/today/presentation/today_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/today/application/today_state.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

import 'widgets/today_header.dart';
import 'widgets/start_continue_cta.dart';
import 'widgets/prs_badge.dart';
import 'widgets/last_workout_preview.dart';

// Create a single WatchConnectivity instance you can reuse.
final _watch = WatchConnectivity();

// -----------------------------------------------------------------------------
// --- TODAY SCREEN WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(lastWorkoutProvider.future),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              AppTheme.sizing.baseGrid * 2,
              0,
              AppTheme.sizing.baseGrid * 2,
              100.0,
            ),
            children: [
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const TodayHeader(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const StartContinueCTA(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const LastWorkoutPreview(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const PRsBadge(),

              // --- CORRECTED: Ping Watch button using watch_connectivity ---
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final reachable = await _watch.isReachable;
                    if (!reachable) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Watch not reachable — open the watch app.'),
                          ),
                        );
                      }
                      return;
                    }

                    // watch_connectivity uses simple Map payloads.
                    await _watch.sendMessage({'type': 'ping'});

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ping sent to watch!')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error sending ping: $e')),
                      );
                    }
                  }
                },
                child: const Text('Ping Watch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}