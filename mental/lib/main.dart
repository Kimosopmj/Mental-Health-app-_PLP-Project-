import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MentalAwarenessApp());
}

class MentalAwarenessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Awareness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of daily affirmations
  final List<String> _affirmations = [
    "You are capable of amazing things.",
    "You are stronger than you think.",
    "Every day is a new beginning.",
    "Believe in yourself.",
    "You are enough."
  ];

  // Get today's affirmation based on the date
  String _getTodaysAffirmation() {
    int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
    return _affirmations[dayOfYear % _affirmations.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mental Awareness App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Daily Affirmation:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                _getTodaysAffirmation(),
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MoodPage()),
                  );
                },
                child: Text('Track Your Mood'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WriteFeelingPage()),
                  );
                },
                child: Text('Write Your Feelings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  // Variable to store the selected mood
  String _mood = 'Happy';
  // Mapping of moods to emojis
  final Map<String, String> _moodEmojis = {
    'Happy': '😊',
    'Sad': '😢',
    'Anxious': '😟',
    'Calm': '😌',
    'Angry': '😠'
  };

  // Function to update the mood and show feedback dialog
  void _updateMood(String mood) {
    setState(() {
      _mood = mood;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoodRatingPage(mood: mood)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Mood'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _mood,
                items: _moodEmojis.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: <Widget>[
                        Text(_moodEmojis[value] ?? ''),
                        SizedBox(width: 10),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _updateMood(newValue);
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                'Selected Mood: ${_moodEmojis[_mood]} $_mood',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodRatingPage extends StatelessWidget {
  final String mood;

  MoodRatingPage({required this.mood});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Your $mood Mood'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Rate your $mood feeling:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              for (int i = 1; i <= 5; i++)
                ElevatedButton(
                  onPressed: () {
                    _showFeedback(context, i);
                  },
                  child: Text('$i'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeedback(BuildContext context, int rating) {
    String feedback = _getFeedbackForMoodRating(rating);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Feedback'),
          content: Text(feedback),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _getFeedbackForMoodRating(int rating) {
    switch (rating) {
      case 1:
        return 'It seems like you are having a tough time. Remember, it’s okay to seek help.';
      case 2:
        return 'Things might be difficult right now. Try to take a break and breathe.';
      case 3:
        return 'You are doing okay. Keep up the positive attitude!';
      case 4:
        return 'Great! You are doing well. Keep it up!';
      case 5:
        return 'Fantastic! Keep spreading the happiness!';
      default:
        return '';
    }
  }
}

class WriteFeelingPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Your Feelings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'How do you feel?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write about your feelings...',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Display a message and clear the text field
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your feelings have been saved.')),
                  );
                  _controller.clear();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
