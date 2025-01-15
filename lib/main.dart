import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase 초기화 패키지
import 'login_screen.dart'; // 로그인 화면으로 이동
import 'home_screen.dart'; // 홈 화면을 위한 파일 임포트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
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
        // 다른 라우트들도 여기 추가 가능
      },
    );
  }
}
