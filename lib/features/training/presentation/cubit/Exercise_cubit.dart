import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/data/models/exercise_model.dart';
import 'package:samla_app/features/training/data/repositories/exercise_repository_impl.dart';

class ExerciseState {
  final bool isLoading;
  final List<ExerciseModel> exercises;
  final String error;

  ExerciseState({required this.isLoading, this.exercises = const [], this.error = ''});
}

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository _exerciseRepository;

  ExerciseCubit(this._exerciseRepository) : super(ExerciseState(isLoading: true));

  void fetchExercises() async {
    try {
      var exercises = await _exerciseRepository.getExercises();
      emit(ExerciseState(isLoading: false, exercises: exercises));
    } catch (e) {
      emit(ExerciseState(isLoading: false, error: e.toString()));
    }
  }
}
