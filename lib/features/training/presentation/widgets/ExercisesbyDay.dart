import 'package:flutter/material.dart';

import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/MainPageExerciseItem.dart';

Widget buildExercisesForDay(BuildContext context, int index, weeklyExercises) {
  String dayName = _getDayNameFromIndex(index);
  var exercises = weeklyExercises[dayName] ?? [];

  if (exercises.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // big icon in the centre icon.auto_awesome_motion
          Icon(
            Icons.battery_saver,
            size: 120,
            color: Colors.white,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            "No exercises for today, take a rest!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // meadia query for the size of the screen
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
  return _buildExercisesList(exercises);
}

String _getDayNameFromIndex(int index) {
  switch (index) {
    case 0:
      return "Sunday";
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    default:
      return "Unknown Day";
  }
}

Widget _buildExercisesList(List<ExerciseLibrary> exercises) {
  return Expanded(
    // Wrap ListView with Expanded
    child: ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return ExerciseTiles(
          exercise: ExercisesItem(
            name: exercise.name,
            bodyPart: exercise.bodyPart,
            equipment: exercise.equipment,
            gifUrl: exercise.gifUrl,
            target: exercise.target,
            instructions: exercise.instructions,
            secondaryMuscles: exercise.secondaryMuscles,
          ),
        );
      },
    ),
  );
}
