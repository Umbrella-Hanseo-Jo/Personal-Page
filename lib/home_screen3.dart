import 'package:flutter/material.dart';

class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAPPY'),
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
