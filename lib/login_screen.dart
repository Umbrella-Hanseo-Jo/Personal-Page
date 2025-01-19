import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase 인증 패키지
import 'phone_auth_screen.dart'; // 전화번호 인증 화면을 위한 파일 추가

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // FirebaseAuth 인스턴스
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 로그인 메소드
  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // 로그인 성공 시, 홈 화면으로 이동(이전 화면을 모두 제거)
        if (mounted) {
          // mounted 체크 추가
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home', // 네임드 라우트 이름
            (Route<dynamic> route) => false, // 모든 이전 화면 제거
          );
        }
      } catch (e) {
        // 로그인 실패 시 에러 메시지 출력
        if (mounted) {
          // mounted 체크 추가
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패: ${e.toString()}')),
          );
        }
      }
    }
  }

  // 회원가입 메소드
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // 회원가입 후 홈 화면으로 이동(이전 화면을 모두 제거)
        if (mounted) {
          // mounted 체크 추가
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home', // 네임드 라우트 이름
            (Route<dynamic> route) => false, // 모든 이전 화면 제거
          );
        }
      } catch (e) {
        // 회원가입 실패 시 에러 메시지 출력
        if (mounted) {
          // mounted 체크 추가
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('회원가입 실패: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Log In'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // 전화번호 인증 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhoneAuthScreen()),
                  );
                },
                child: const Text('Log In with Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
