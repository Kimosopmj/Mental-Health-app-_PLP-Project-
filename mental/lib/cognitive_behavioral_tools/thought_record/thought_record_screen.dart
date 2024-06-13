import 'package:flutter/material.dart';
import 'thought_entry.dart';

class ThoughtRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thought Record')),
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
          ThoughtEntry(),
        ],
      ),
    );
  }
}
