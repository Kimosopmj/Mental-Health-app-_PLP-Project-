import 'models/thought.dart';
import 'models/exercise.dart';
import 'models/chat_message.dart';
import 'models/peer.dart';

class MockDatabase {
  List<Thought> thoughts = [];
  List<Exercise> exercises = [
    Exercise(title: 'Exercise 1', description: 'Step-by-step guide for Exercise 1'),
    Exercise(title: 'Exercise 2', description: 'Step-by-step guide for Exercise 2')
  ];
  List<ChatMessage> chatMessages = [];
  List<Peer> peers = [
    Peer(name: 'Alice', interests: 'Reading, Hiking'),
    Peer(name: 'Bob', interests: 'Movies, Sports')
  ];

  void addThought(Thought thought) {
    thoughts.add(thought);
  }

  void addChatMessage(ChatMessage message) {
    chatMessages.add(message);
  }

  Peer? matchPeer() {
    if (peers.isNotEmpty) {
      return peers[0];
    }
    return null;
  }
}

final mockDatabase = MockDatabase();
