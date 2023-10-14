import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/training/presentation/widgets/routineButtons.dart';

class NewWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Workout'),
        backgroundColor: theme_green,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'images/qrcode.svg',
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/QRcode'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.fitness_center,
                size: 50.0,
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Get started',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Add an exercise or scan QR code or NFC tag to add an Exercise',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton.icon(
                onPressed: () {
                  _showAddExerciseSheet(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme_green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddExerciseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // allows the bottom sheet to be displayed at its full height
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,  // 90% of screen height
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle filter button 1 press
                        },
                        child: const Text('Filter tt1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme_green,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),  // Adds some space between the two buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle filter button 2 press
                        },
                        child: const Text('Filtesssr 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme_green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}





// MuscleGroupCard(
//   muscleGroupName: 'Chest',
//   imageUrl: 'https://v2.exercisedb.io/image/mC3NaRoKzI9D-S',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Back',
//   imageUrl: 'https://v2.exercisedb.io/image/Df5zu4OmWB97T8',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Shoulders',
//   imageUrl: 'https://v2.exercisedb.io/image/rJaV3eeqGfGiIl',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Biceps',
//   imageUrl: 'https://v2.exercisedb.io/image/motQtaEI1aag0C',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Triceps',
//   imageUrl: 'https://v2.exercisedb.io/image/r8nXDRpWfBw7Qu',
// ),