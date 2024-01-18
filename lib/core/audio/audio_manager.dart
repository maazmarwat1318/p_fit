import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioManagerProvider = Provider<AudioManager>((ref) {
  return AudioManager();
});

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const startBeep = 'start_beep';
  static const stopBeep = 'stop_beep';
  static const startCount3 = 'start_count_3';
  void initAudioManager() {
    _audioPlayer.audioCache.loadAll([
      'audio/start_beep.mp3',
      'audio/start_count_3.mp3',
      'audio/stop_beep.mp3'
    ]);
  }

  void playAudio(String name) {
    _audioPlayer.play(AssetSource('audio/$name.mp3'));
  }

  void stopAudio() {
    if (_audioPlayer.state == PlayerState.playing) _audioPlayer.stop();
  }
}
