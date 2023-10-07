import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/widgets/routineCard.dart';
import 'package:samla_app/features/training/presentation/widgets/routineButtons.dart';
import 'package:samla_app/features/training/presentation/widgets/sectionTitle.dart';

import '../widgets/TransparentBox.dart';
import '../widgets/expandableBox.dart';
import 'ex.dart';

class TrainingPage extends StatelessWidget {
  TrainingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Quick Start and Routines section
              ExpandableBox(
                title: "Quick Start & Routines",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'Quick Start'),
                    SizedBox(height: 8),
                    StartWorkoutButton(),
                    SizedBox(height: 16),
                    SectionTitle(title: 'Routines'),
                    SizedBox(height: 8),
                    RoutineButtons(),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // My Routines section
              TransparentBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'My Routines'),
                    SizedBox(height: 8),
                    RoutineCard(title: 'Pull Routine', exercises: [
                      Exercise(name: 'Pull-Ups'),
                      Exercise(name: 'Chin-Ups'),
                      Exercise(name: 'Deadlifts'),
                    ]),
                    SizedBox(height: 8),
                    RoutineCard(title: 'Push Routine', exercises: [
                      Exercise(name: 'Push-Ups'),
                      Exercise(name: 'Bench Press'),
                      Exercise(name: 'Dips'),
                    ]),
                    SizedBox(height: 8),
                    RoutineCard(title: 'Lose Weight Routine', exercises: [
                      Exercise(name: 'Cardio'),
                      Exercise(name: 'Healthy Diet'),
                      Exercise(name: 'Planks'),
                    ]),
                    SizedBox(height: 8),
                    RoutineCard(title: 'Gain Weight Routine', exercises: [
                      Exercise(name: 'Weightlifting'),
                      Exercise(name: 'Protein Intake'),
                      Exercise(name: 'Squats')
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
