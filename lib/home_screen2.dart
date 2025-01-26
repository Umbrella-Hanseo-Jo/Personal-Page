import 'package:flutter/material.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Show'),
      ),
      body: Center(
        child: const Text(
          'this is my nextpage!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
