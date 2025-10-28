// lib/src/features/workout/application/wear_timer_sync_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';

// -----------------------------------------------------------------------------
// --- WEAR TIMER SYNC SERVICE -------------------------------------------------
// -----------------------------------------------------------------------------

/// A service that coalesces high-frequency timer changes and ships them to a
/// connected Wear OS device using a hybrid strategy for reliability and efficiency.
class WearTimerSyncService {
  final FlutterWearOsConnectivity _wear = FlutterWearOsConnectivity();
  final String _messagePath = "/timer/update";
  final String _dataPath = "/timer/snapshot";
  final Duration _snapshotCadence = const Duration(seconds: 7);

  Timer? _snapshotTimer;
  TimerState? _latestState;

  /// Initializes the Wearable API. Must be called before other methods.
  Future<void> init() async {
    await _wear.configureWearableAPI();
  }

  /// Listens to the Riverpod timer provider and sends updates to the watch.
  void attach(Ref ref) {
    // Listen for every change to the timer state.
    ref.listen<TimerState>(timerStateProvider, (previous, next) {
      _latestState = next;
      // Send an immediate message for important state transitions.
      if (previous?.isRunning != next.isRunning) {
        _flushMessage();
      }
    }, fireImmediately: true);

    // Start a periodic timer to send reliable state snapshots.
    _snapshotTimer ??= Timer.periodic(_snapshotCadence, (_) => _flushSnapshot());
  }

  /// Sends the latest state via the high-priority MessageClient.
  /// This is for low-latency updates when the app is in the foreground.
  Future<void> _flushMessage() async {
    if (_latestState == null) return;
    final payload = utf8.encode(jsonEncode(_latestState!.toMap()));
    try {
      // --- FIX: Fetch connected devices and send a message to each one. ---
      final connectedDevices = await _wear.getConnectedDevices();
      for (final device in connectedDevices) {
        await _wear.sendMessage(
          payload,
          deviceId: device.id, // Now guaranteed to be a non-null String
          path: _messagePath,
          priority: MessagePriority.high,
        );
      }
    } catch (_) {
      // Errors are expected if the watch is not connected; the snapshot will heal the state.
    }
  }

  /// Syncs the latest state via the persistent DataClient.
  /// This ensures the watch gets the correct state upon reconnecting.
  Future<void> _flushSnapshot() async {
    if (_latestState == null) return;
    try {
      await _wear.syncData(
        path: _dataPath,
        data: _latestState!.toMap(),
        isUrgent: false, // Allows the system to coalesce updates to save battery.
      );
    } catch (_) {
      // Errors are expected if the watch is not connected.
    }
  }

  /// Cancels any active timers.
  void dispose() {
    _snapshotTimer?.cancel();
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A global provider for the WearTimerSyncService instance.
final wearTimerSyncServiceProvider = Provider<WearTimerSyncService>((ref) {
  final service = WearTimerSyncService();
  // Attach the service to the Riverpod ref to listen for timer state changes.
  service.attach(ref);
  // Dispose of the service's resources when the provider is disposed.
  ref.onDispose(() => service.dispose());
  return service;
});