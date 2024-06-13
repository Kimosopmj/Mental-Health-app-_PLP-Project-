import 'package:flutter/material.dart';
import 'cbt_guide.dart';

class CBTExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CBT Exercises')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54,
          ),
          CBTGuide(),
        ],
      ),
    );
  }
}
