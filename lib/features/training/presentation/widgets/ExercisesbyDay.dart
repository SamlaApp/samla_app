import 'package:flutter/material.dart';

import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/MainPageExerciseItem.dart';

Widget buildExercisesForDay(BuildContext context, int index, weeklyExercises) {
  String dayName = _getDayNameFromIndex(index);
  var exercises = weeklyExercises[dayName] ?? [];

  if (exercises.isEmpty) {
    return Text("No exercises for $dayName");
  }
  return _buildExercisesList(exercises);
}
String _getDayNameFromIndex(int index) {
  switch (index) {
    case 0: return "Sunday";
    case 1: return "Monday";
    case 2: return "Tuesday";
    case 3: return "Wednesday";
    case 4: return "Thursday";
    case 5: return "Friday";
    case 6: return "Saturday";
    default: return "Unknown Day";
  }
}


Widget _buildExercisesList(List<ExerciseLibrary> exercises) {
  print(
      exercises[0].gifUrl
  );
  return Expanded( // Wrap ListView with Expanded
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
