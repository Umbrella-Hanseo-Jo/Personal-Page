import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // audioplayers 패키지
import 'package:flutter/foundation.dart'; // kIsWeb을 사용하기 위한 패키지

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // AudioPlayer 객체 생성

  @override
  void initState() {
    super.initState();

    // 웹에서는 사용자의 상호작용을 기다려야 하므로 자동으로 음악을 재생하지 않음
    if (!kIsWeb) {
      // 모바일에서는 앱 실행 시 음악 자동 재생
      _playBackgroundMusic();
    }
  }

  // 배경 음악 재생 메소드
  void _playBackgroundMusic() async {
    // assets 폴더 내의 오디오 파일 재생
    await _audioPlayer.setSource(AssetSource('wtts.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // 반복 재생
    await _audioPlayer.resume(); // 음악 재생 시작
  }

  // 배경 음악 정지하는 메소드
  void _stopBackgroundMusic() async {
    await _audioPlayer.stop(); // 음악 정지
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // 페이지가 사라질 때 오디오 리소스를 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Show'),
      ),
      backgroundColor: Colors.white, // 배경을 하얀색으로 설정
      body: Stack(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth, // 좌우는 꽉 차게 하고, 상하 비율은 유지
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // 화면 너비를 맞춤
              child: Image.asset('3000x3000four.jpg'), // 이미지 로드
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'this is my nextpage!',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20), // 간격 추가

                ElevatedButton(
                  onPressed: _playBackgroundMusic, // 음악 재생
                  child: const Text('음악 시작'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _stopBackgroundMusic, // 음악 정지
                  child: const Text('음악 정지'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home3'); // '/home3'로 이동
                  },
                  child: const Text('클릭'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
