import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  AudioPlayer get audioPlayer => _audioPlayer;

  // 음악 시작
  Future<void> play(String asset) async {
    await _audioPlayer.setSource(AssetSource(asset));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // 음악 정지
  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  // 음악 상태 변경
  void togglePlayPause(String asset) {
    if (_isPlaying) {
      stop();
    } else {
      play(asset);
    }
  }

  // AudioPlayer를 초기화하는 메서드
  void reset() {
    _audioPlayer.stop();
    _isPlaying = false;
  }
}
