import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // audioplayers 패키지 임포트
import 'package:flutter/foundation.dart'; // kIsWeb을 사용하기 위한 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOME SWEET HOME',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HOME SWEET HOME'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    await _audioPlayer.setSource(AssetSource('good.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // 반복 재생
    await _audioPlayer.resume(); // 음악 재생 시작
  }

  // 배경 음악 정지하는 메소드
  void _stopBackgroundMusic() async {
    await _audioPlayer.stop(); // 음악 정지
  }

  // 화면 중앙에 스타일리시한 Dialog (팝업 메시지) 띄우는 메소드
  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 둥근 모서리
          ),
          elevation: 10, // 그림자 효과
          backgroundColor: Colors.deepPurple, // 배경 색상
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 내용에 맞춰 크기 조정
              children: [
                const Icon(Icons.home, size: 60, color: Colors.deepPurple),
                const SizedBox(height: 20),
                const Text(
                  'HOME SWEET HOME',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업을 닫기 위한 동작
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // 버튼 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 둥근 버튼
                    ),
                  ),
                  child: const Text('닫기',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white, // 배경을 하얀색으로 설정
      body: Stack(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth, // 좌우는 꽉 차게 하고, 상하 비율은 유지
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // 화면 너비를 맞춤
              child: Image.asset('5000x5000bb.jpg'), // 이미지 로드
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome, this is my homepage!',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20), // 간격 추가

                ElevatedButton(
                  onPressed: () {
                    _showMessage(context); // 버튼 클릭 시 메시지 출력
                    if (kIsWeb) {
                      // 웹에서는 버튼 클릭 후에 음악 재생
                      _playBackgroundMusic();
                    }
                  },
                  child: const Text('시작하기'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _stopBackgroundMusic, // 음악 정지
                  child: const Text('음악 정지'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
