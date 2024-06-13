// import 'package:flutter/material.dart';
// import 'package:Ustawi/taskscreens/landingpage.dart';

// void main() {
//   runApp(MentalHealthApp());
// }

// class MentalHealthApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ustawi',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LandingPage(), // Set the landing page as the home screen
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'cognitive_behavioral_tools/thought_record/thought_record_screen.dart';
import 'cognitive_behavioral_tools/cbt_exercises/cbt_exercise_screen.dart';
import 'social_features/community_support/community_chat_screen.dart';
import 'social_features/peer_support_matching/peer_matching_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mental Health App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThoughtRecordScreen()),
                );
              },
              child: Text('Thought Record'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CBTExerciseScreen()),
                );
              },
              child: Text('CBT Exercises'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityChatScreen()),
                );
              },
              child: Text('Community Support'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeerMatchingScreen()),
                );
              },
              child: Text('Peer Support Matching'),
            ),
          ],
        ),
      ),
    );
  }
}
