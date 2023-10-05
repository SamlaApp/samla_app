import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'new_workout.dart';
class TrainingPage extends StatelessWidget {
  TrainingPage({Key? key});

  // final user = LocalAuth.user;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(title: 'Quick Start'),
            SizedBox(height: 8),
            StartWorkoutButton(),
            SizedBox(height: 16),
            SectionTitle(title: 'Routines'),
            SizedBox(height: 8),
            RoutineButtons(),
            SizedBox(height: 16),
            SectionTitle(title: 'My Routines'),
            SizedBox(height: 8),
            RoutineCard(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
    );
  }
}

class StartWorkoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewWorkout(),
          ),
        );
      },
      icon: Icon(Icons.add),
      label: Text('Start New Workout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: theme_green),
    );
  }
}

class RoutineButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: RoutineButton(icon: Icons.save_alt, label: 'New Routine', onPressed: () {})),
        SizedBox(width: 8),
        Expanded(child: RoutineButton(icon: Icons.search, label: 'Explore Routines', onPressed: () {})),
      ],
    );
  }
}

class RoutineButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const RoutineButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: theme_green,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

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





