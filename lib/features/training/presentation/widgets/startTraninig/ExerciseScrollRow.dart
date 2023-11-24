import 'package:flutter/material.dart';
import '../../../../../config/themes/common_styles.dart';
import '../../../domain/entities/ExerciseLibrary.dart';

class ExerciseScrollRow extends StatelessWidget {
  final List<ExerciseLibrary> exercises;
  final ExerciseLibrary selectedExercise;
  final Function(ExerciseLibrary) onExerciseSelect;
  final String baseURL = 'https://samla.mohsowa.com/api/training/image/';

  ExerciseScrollRow({
    required this.exercises,
    required this.selectedExercise,
    required this.onExerciseSelect,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primary_decoration.copyWith(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 80, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          bool isSelected = selectedExercise == exercise;

          return InkWell(
            onTap: () => onExerciseSelect(exercise),
            child: Container(
              width: 65,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey[300]!,
                  width: isSelected ? 3 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                baseURL + exercise.gifUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
