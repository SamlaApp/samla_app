import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';

class exploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Routine'),
        backgroundColor: theme_green,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              // Handle QR code button press
              // You can navigate to a QR code screen here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyRoutines.length,
        itemBuilder: (BuildContext context, int index) {
          final title = dummyRoutines[index].title;
          final exercises = dummyRoutines[index].exercises;

          return RoutineCard(
            title: title,
            exercises: exercises,
          );
        },
      ),
    );
  }
}
class Exercise {
  final String name;
  final String description;

  Exercise({required this.name, required this.description});
}

class Routine {
  final String title;
  final List<Exercise> exercises;

  Routine({required this.title, required this.exercises});
}

final List<Routine> dummyRoutines = [
  Routine(
    title: 'Push Routine',
    exercises: [
      Exercise(name: 'Push-Ups', description: 'Do 15 push-ups'),
      Exercise(name: 'Bench Press', description: 'Lift weights on a bench lkajhfldakj laskjdfhalksjf '),
      Exercise(name: 'Dips', description: 'Do 12 dips'),
    ],
  ),
  Routine(
    title: 'Lose Weight Routine',
    exercises: [
      Exercise(name: 'Cardio', description: 'Run for 30 minutes'),
      Exercise(name: 'Healthy Diet', description: 'Eat balanced meals'),
      Exercise(name: 'Planks', description: 'Hold for 1 minute'),
    ],
  ),
  Routine(
    title: 'Gain Weight Routine',
    exercises: [
      Exercise(name: 'Weightlifting', description: 'Lift heavy weights'),
      Exercise(name: 'Protein Intake', description: 'Consume more protein'),
      Exercise(name: 'Squats', description: 'Do 10 squats'),
    ],
  ),
];


class RoutineCard extends StatefulWidget {
  final String title;
  final List<Exercise> exercises;

  RoutineCard({required this.title, required this.exercises});

  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      color: primary_color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 16.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isAdded = !_isAdded;
                    });
                  },
                  child: Icon(
                    _isAdded ? Icons.check : Icons.add,
                    color: Colors.cyan, // Set the icon color
                    size: 24.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            height: 90,
            child: widget.exercises != null && widget.exercises.isNotEmpty
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.exercises
                    .map((exercise) => ExerciseCard(exercise: exercise))
                    .toList(),
              ),
            )
                : Text("No exercises available"),
          ),
        ],
      ),
    );
  }
}


class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
        color: Colors.grey[200],
        child: ListTile(
          title: Text(
            exercise.name,
            overflow: TextOverflow.ellipsis, // Truncate with ellipsis
            maxLines: 1, // Limit to a single line
          ),
          subtitle: Text(
            exercise.description,
            overflow: TextOverflow.ellipsis, // Truncate with ellipsis
            maxLines: 1, // Limit to a single line
          ),
          onTap: () {
            // Handle exercise item tap
            // navigate to an exercise detail screen here
          },
        ),
      ),
    );
  }
}