// lib/src/core/services/alert_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Riverpod for creating a service provider.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The audioplayers package for playing a sound alert.
import 'package:audioplayers/audioplayers.dart';

// The vibration package for haptic feedback.
import 'package:vibration/vibration.dart';

// -----------------------------------------------------------------------------
// --- ALERT SERVICE CLASS -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A service class responsible for providing user alerts, such as sounds and
/// haptic feedback, for events like timer completion.
class AlertService {
  final AudioPlayer _audioPlayer;

  AlertService(this._audioPlayer);

  /// --- UPDATED METHOD ---
  /// Triggers only a warning sound, without haptic feedback.
  Future<void> triggerTimerWarningAlert() async {
    // Play the warning sound asset.
    await _audioPlayer.play(AssetSource('audio/timer_warning.mp3'));
  }

  /// Triggers a combination of haptic feedback and an audible alert to notify
  /// the user that their rest timer has finished.
  Future<void> triggerTimerCompletionAlert() async {
    // --- HAPTIC FEEDBACK ---
    final bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator ?? false) {
      // Trigger a standard, longer vibration pattern.
      Vibration.vibrate();
    }

    // --- AUDIO FEEDBACK ---
    await _audioPlayer.play(AssetSource('audio/timer_complete.mp3'));
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDERS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A provider for a singleton instance of the AudioPlayer.
final _audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  // Clean up the audio player when the provider is disposed.
  ref.onDispose(() => player.dispose());
  return player;
});

/// The main provider that makes the AlertService available to the rest of the app.
/// It depends on the `_audioPlayerProvider` to get its AudioPlayer instance.
final alertServiceProvider = Provider<AlertService>((ref) {
  return AlertService(ref.watch(_audioPlayerProvider));
});