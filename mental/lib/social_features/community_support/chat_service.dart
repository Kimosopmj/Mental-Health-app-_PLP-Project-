import 'package:flutter/material.dart';
import '../../mock_database.dart';
import '../../models/chat_message.dart';

class ChatService extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: mockDatabase.chatMessages.length,
            itemBuilder: (ctx, index) {
              final message = mockDatabase.chatMessages[index];
              return ListTile(
                title: Text(
                  message.text,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  message.timestamp.toString(),
                  style: TextStyle(color: Colors.white70),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: 'Enter your message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  final text = _controller.text;
                  if (text.isNotEmpty) {
                    mockDatabase.addChatMessage(ChatMessage(text: text, timestamp: DateTime.now()));
                    _controller.clear();
                    (context as Element).reassemble(); // Refresh UI
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
