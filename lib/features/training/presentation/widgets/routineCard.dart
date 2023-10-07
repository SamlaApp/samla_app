import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class RoutineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sunday', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                RoutineCardMenu(),
              ],
            ),
            SizedBox(height: 8),
            Text('Back, Chest', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.play_arrow),
              label: Text('Start Now'),
              style: ElevatedButton.styleFrom(backgroundColor: theme_green),
            ),
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