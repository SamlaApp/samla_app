import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/training/presentation/pages/ex.dart';

import '../pages/startTrainig.dart';
class RoutineCard extends StatelessWidget {
  final String title;
  final List<Exercise> exercises;

  RoutineCard({
    required this.title,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                RoutineCardMenu(),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercises
                      .map((exercise) => exercise?.name ?? '')
                      .join(', '), // Join exercise names with a comma and space
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => startTraining()),
                );
              },
              icon: Icon(Icons.play_arrow),
              label: Text('Start Now'),
              style: ElevatedButton.styleFrom(backgroundColor: theme_green),
            )
          ],
        ),
      ),
    );
  }
}


class RoutineCardMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(value: 1, child: Text("Share")),
        PopupMenuItem(value: 2, child: Text("Edit")),
        PopupMenuItem(value: 3, child: Text("Delete", style: TextStyle(color: theme_red))),
      ],
      onSelected: (value) {
        // Handle menu selection
      },
      icon: Icon(Icons.more_vert),
    );
  }
}



