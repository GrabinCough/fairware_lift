// lib/src/core/services/alert_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

// -----------------------------------------------------------------------------
// --- ALERT SERVICE CLASS -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A service class responsible for providing user alerts, such as sounds and
/// haptic feedback, for events like timer completion.
class AlertService {
  final AudioPlayer _audioPlayer;

  AlertService(this._audioPlayer) {
    // Configure the audio player as soon as the service is created.
    _configureAudioPlayer();
  }

  /// Configures the global audio context for the app's sound effects.
  Future<void> _configureAudioPlayer() async {
    final audioContext = AudioContext(
      // iOS Configuration
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        // --- FIX ---
        // The `options` parameter requires a Set {}, not a List [].
        // This has been corrected.
        options: {
          AVAudioSessionOptions.duckOthers,
        },
      ),
      // Android Configuration
      android: AudioContextAndroid(
        isSpeakerphoneOn: true,
        audioFocus: AndroidAudioFocus.gainTransient,
        usageType: AndroidUsageType.alarm,
      ),
    );
    // Apply the configuration to our audio player instance.
    await _audioPlayer.setAudioContext(audioContext);
  }

  /// Triggers only a warning sound, without haptic feedback.
  Future<void> triggerTimerWarningAlert() async {
    await _audioPlayer.play(AssetSource('audio/timer_warning.mp3'));
  }

  /// Triggers a combination of haptic feedback and an audible alert to notify
  /// the user that their rest timer has finished.
  Future<void> triggerTimerCompletionAlert() async {
    final bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator ?? false) {
      Vibration.vibrate();
    }
    await _audioPlayer.play(AssetSource('audio/timer_complete.mp3'));
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDERS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

final _audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
});

final alertServiceProvider = Provider<AlertService>((ref) {
  return AlertService(ref.watch(_audioPlayerProvider));
});