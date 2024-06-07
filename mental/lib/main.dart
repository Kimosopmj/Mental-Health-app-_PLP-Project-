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

  // Function to update the mood and navigate to the rating page
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
    String feedback = _getFeedbackForMoodRating(mood, rating);
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

  String _getFeedbackForMoodRating(String mood, int rating) {
    Map<String, List<String>> feedbackMap = {
      'Happy': [
        'Great to hear you are happy! Keep spreading positivity!',
        'You seem quite happy! Enjoy the moment!',
        'You are feeling good! Keep it up!',
        'You are very happy! It’s great to see that!',
        'You are extremely happy! Share your joy with others!',
      ],
      'Sad': [
        'It’s okay to feel sad. Take care and talk to someone you trust.',
        'Feeling down? Try doing something you love.',
        'It’s natural to feel sad. Take some time for yourself.',
        'You seem quite sad. Don’t hesitate to reach out for support.',
        'You are feeling very sad. Please talk to someone close to you.',
      ],
      'Anxious': [
        'Feeling anxious is tough. Try some deep breathing exercises.',
        'You seem a bit anxious. Take a moment to relax.',
        'Anxiety can be overwhelming. Remember to take things one step at a time.',
        'You are feeling quite anxious. Try some mindfulness techniques.',
        'Your anxiety level is high. Consider speaking to a professional.',
      ],
      'Calm': [
        'Glad to hear you are calm. Keep it up!',
        'You seem relaxed. Enjoy the calmness!',
        'Feeling calm is great. Maintain this peaceful state.',
        'You are quite calm. Keep this positive state of mind.',
        'You are extremely calm. Continue to enjoy the tranquility.',
      ],
      'Angry': [
        'Anger is a natural emotion. Try to relax and cool down.',
        'Feeling angry? Take a moment to breathe deeply.',
        'It’s okay to be angry. Consider doing some physical activity to release it.',
        'You seem quite angry. Try to find a peaceful activity to distract yourself.',
        'Your anger level is high. It might help to talk to someone about it.',
      ],
    };

    return feedbackMap[mood]?[rating - 1] ?? '';
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
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the feelings to a database or show a confirmation message
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
