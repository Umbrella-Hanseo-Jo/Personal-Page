import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // audioplayers 패키지
import 'package:flutter/foundation.dart'; // kIsWeb을 사용하기 위한 패키지
import 'package:back_button_interceptor/back_button_interceptor.dart'; // back_button_interceptor 패키지

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

    // 뒤로 가기 버튼 동작을 가로채는 인터셉터
    BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) =>
        _onBackPressed(stopDefaultButtonEvent));
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

  // 뒤로가기 버튼을 눌렀을 때의 동작을 정의하는 함수
  bool _onBackPressed(bool stopDefaultButtonEvent) {
    Navigator.pop(context); // 페이지 닫기, 음악 계속 재생
    return true; // 뒤로가기 동작 가로챔
  }

  @override
  void dispose() {
    // 뒤로가기 인터셉터 제거
    BackButtonInterceptor.remove((stopDefaultButtonEvent, routeInfo) =>
        _onBackPressed(stopDefaultButtonEvent));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Show'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기 동작만 처리
          },
        ),
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
