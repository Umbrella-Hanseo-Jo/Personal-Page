import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase 인증 패키지

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  PhoneAuthScreenState createState() => PhoneAuthScreenState();
}

class PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _smsController = TextEditingController();
  String verificationId = ''; // 인증 ID
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 전화번호로 인증 요청하는 메소드
  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        if (mounted) {
          // mounted 체크 추가
          // 인증이 자동으로 완료되면 로그인 후 홈 화면으로 이동
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (mounted) {
          // mounted 체크 추가
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('인증 실패: ${e.message}')),
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (mounted) {
          // mounted 체크 추가
          setState(() {
            this.verificationId = verificationId;
          });
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) {
          // mounted 체크 추가
          setState(() {
            this.verificationId = verificationId;
          });
        }
      },
    );
  }

  // 인증 코드 입력 후 로그인 메소드
  Future<void> _signInWithPhoneNumber() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: _smsController.text,
    );

    await _auth.signInWithCredential(credential).then((userCredential) {
      if (mounted) {
        // mounted 체크 추가
        Navigator.pushReplacementNamed(context, '/home');
      }
    }).catchError((e) {
      if (mounted) {
        // mounted 체크 추가
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 코드가 잘못되었습니다.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: const Text('Send OTP'),
            ),
            TextField(
              controller: _smsController,
              decoration: const InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
