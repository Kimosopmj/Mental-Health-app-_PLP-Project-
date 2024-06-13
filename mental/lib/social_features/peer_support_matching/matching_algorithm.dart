import 'package:flutter/material.dart';
import '../../mock_database.dart';

class PeerMatchingAlgorithm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final matchedPeer = mockDatabase.matchPeer();
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Matched Peer'),
              content: Text(
                matchedPeer != null
                    ? 'Name: ${matchedPeer.name}\nInterests: ${matchedPeer.interests}'
                    : 'No peers available for matching.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Text('Find a Peer Support'),
      ),
    );
  }
}
