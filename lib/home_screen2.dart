import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 패키지
import 'audio_provider.dart'; // AudioProvider 설정 파일

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

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

                // context.watch()를 통해 상태 변화를 감지하고, UI를 자동으로 업데이트
                ElevatedButton(
                  onPressed: () {
                    // 상태 변화 (토글)
                    context.read<AudioProvider>().togglePlayPause('wtts.mp3');
                  },
                  child: Text(context.watch<AudioProvider>().isPlaying
                      ? '음악 정지'
                      : '음악 시작'),
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
