import 'package:flutter/material.dart';
import '../../../../../config/themes/new_style.dart';
import '../../../domain/entities/ExerciseLibrary.dart';

class ExerciseScrollRow extends StatelessWidget {
  final List<ExerciseLibrary> exercises;
  final ExerciseLibrary selectedExercise;
  final Function(ExerciseLibrary) onExerciseSelect;
  final String baseURL = 'https://samla.mohsowa.com/api/training/image/';

  const ExerciseScrollRow({
    super.key,
    required this.exercises,
    required this.selectedExercise,
    required this.onExerciseSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          bool isSelected = selectedExercise == exercise;

          return InkWell(
            onTap: () => onExerciseSelect(exercise),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.18,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? themeDarkBlue : themeGrey,
                  width: isSelected ? 3 : 1,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  baseURL + exercise.gifUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
