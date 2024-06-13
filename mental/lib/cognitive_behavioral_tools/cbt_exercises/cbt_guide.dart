import 'package:flutter/material.dart';
import '../../mock_database.dart';

class CBTGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockDatabase.exercises.length,
      itemBuilder: (ctx, index) {
        final exercise = mockDatabase.exercises[index];
        return Card(
          child: ListTile(
            title: Text(exercise.title),
            subtitle: Text(exercise.description),
            onTap: () {
              // Navigate to detailed exercise screen
            },
          ),
        );
      },
    );
  }
}
