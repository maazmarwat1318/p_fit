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
  Map<String, String?> loadedFilesUrls = {
    'start_beep': null,
    'stop_beep': null,
    'start_count_3': null,
  };
  void initAudioManager() {
    _audioPlayer.audioCache.load('audio/start_beep.mp3').then((value) {
      loadedFilesUrls['start_beep'] = value.path;
    });
    _audioPlayer.audioCache.load('audio/stop_beep.mp3').then((value) {
      loadedFilesUrls['stop_beep'] = value.path;
    });
    _audioPlayer.audioCache.load('audio/start_count_3.mp3').then((value) {
      loadedFilesUrls['start_count_3'] = value.path;
    });
  }

  void playAudio(String name) {
    // print(loadedFilesUrls);
    if (loadedFilesUrls[name] == null) {
      _audioPlayer.play(AssetSource('audio/$name.mp3'));
    } else {
      _audioPlayer.play(DeviceFileSource(loadedFilesUrls[name]!));
    }
  }

  void stopAudio() {
    if (_audioPlayer.state == PlayerState.playing) _audioPlayer.stop();
  }
}
