import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // kIsWeb을 사용하기 위한 패키지
import 'package:provider/provider.dart'; // Provider 패키지
import 'audio_provider.dart'; // AudioProvider 설정 파일

class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    // AudioProvider를 가져옵니다.
    final audioProvider = Provider.of<AudioProvider>(context);

    // 웹에서는 사용자의 상호작용을 기다려야 하므로 자동으로 음악을 재생하지 않음
    if (!kIsWeb && !audioProvider.isPlaying) {
      // 모바일에서는 앱 실행 시 음악 자동 재생
      audioProvider.play('happy.mp3');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HAPPY'),
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
                  onPressed: () {
                    audioProvider.play('happy.mp3'); // 음악 재생
                  },
                  child: const Text('음악 시작'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    audioProvider.stop(); // 음악 정지
                  },
                  child: const Text('음악 정지'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
