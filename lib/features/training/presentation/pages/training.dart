import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/widgets/routineCard.dart';
import 'package:samla_app/features/training/presentation/widgets/routineButtons.dart';
import 'package:samla_app/features/training/presentation/widgets/sectionTitle.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({Key? key});

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








