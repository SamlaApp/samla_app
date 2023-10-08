import 'package:flutter/material.dart';
import '../../../../config/themes/common_styles.dart';
import 'package:samla_app/features/training/presentation/pages/explorescreen.dart';
import 'package:samla_app/features/training/presentation/pages/newRoutineScreen.dart';

class StartWorkoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => exploreScreen(),
          ),
        );
      },
      icon: Icon(Icons.add),
      label: Text('Start New Workout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40), backgroundColor: theme_green),
    );
  }
}

class RoutineButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: RoutineButton(icon: Icons.save_alt, label: 'New Routine', onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewRoutineScreen()
          ));
        })),
        SizedBox(width: 8),
        Expanded(child: RoutineButton(icon: Icons.search, label: 'Explore Routines', onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => exploreScreen()
          ));
        })),
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
        minimumSize: Size(double.infinity, 40),
        backgroundColor: theme_green,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 5),
          Flexible(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
