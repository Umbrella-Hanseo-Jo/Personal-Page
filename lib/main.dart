import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase 초기화 패키지
import 'login_screen.dart'; // 로그인 화면으로 이동
import 'home_screen.dart'; // 홈 화면으로 이동
import 'home_screen2.dart'; // 홈2 화면으로 이동
import 'firebase_options.dart'; // Firebase 설정 파일
import 'package:logger/logger.dart'; // 로깅을 위한 logger 패키지

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var logger = Logger(); // logger 인스턴스 생성

  try {
    // Firebase 초기화 시 FirebaseOptions 전달
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // 플랫폼에 맞는 Firebase 설정
    );
  } catch (e) {
    // Firebase 초기화 실패 시 오류 로그 기록
    logger.e('Firebase initialization failed: $e');
    return;
  }

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
      home: const LoginPage(), // 첫 화면을 로그인 페이지로 설정
      routes: {
        '/home': (context) => const MyHomePage(title: 'HOME SWEET HOME'),
        '/home2': (context) => const HomeScreen2(),
        // 다른 라우트들도 여기 추가 가능
      },
    );
  }
}
