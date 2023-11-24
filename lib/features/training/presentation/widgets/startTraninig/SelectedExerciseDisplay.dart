import 'package:flutter/material.dart';

import '../../../../../config/themes/common_styles.dart';
import '../../../domain/entities/ExerciseLibrary.dart';
import '../ExerciseInfoStartPage.dart';

class SelectedExerciseDisplay extends StatelessWidget {
  final ExerciseLibrary selectedExercise;
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  
  SelectedExerciseDisplay({required this.selectedExercise});

  @override
  Widget build(BuildContext context) {
    return _buildSelectedExerciseDisplay();
  }

  Widget _buildSelectedExerciseDisplay() {
    return Container(
      decoration: primary_decoration,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ExerciseInfoStartPage(
            name: selectedExercise.name,
            gifUrl: baseURL + selectedExercise.gifUrl,
            bodyPart: selectedExercise.bodyPart,
            equipment: selectedExercise.equipment,
            target: selectedExercise.target,
            secondaryMuscles: selectedExercise.secondaryMuscles,
            instructions: selectedExercise.instructions,
          ),
        ],
      ),
    );
  }
}
