import 'package:flutter/material.dart';

import '../../../../../config/themes/common_styles.dart';
import '../../../domain/entities/ExerciseLibrary.dart';
import '../../cubit/History/history_cubit.dart';
import '../ExerciseInfoStartPage.dart';

class SelectedExerciseDisplay extends StatelessWidget {
  final ExerciseLibrary selectedExercise;
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  final HistoryCubit historyCubit;

  const SelectedExerciseDisplay(
      {super.key, required this.selectedExercise, required this.historyCubit});

  @override
  Widget build(BuildContext context) {
    return _buildSelectedExerciseDisplay();
  }

  Widget _buildSelectedExerciseDisplay() {
    return ExerciseInfoStartPage(
      name: selectedExercise.name,
      gifUrl: baseURL + selectedExercise.gifUrl,
      bodyPart: selectedExercise.bodyPart,
      equipment: selectedExercise.equipment,
      target: selectedExercise.target,
      secondaryMuscles: selectedExercise.secondaryMuscles,
      instructions: selectedExercise.instructions,
      historyCubit: historyCubit,
      selectedExercise: selectedExercise,
    );
  }
}
