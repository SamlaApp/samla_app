import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';
import 'package:samla_app/features/training/domain/repositories/exercise_repository.dart';
part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository repository;
  ExerciseCubit(this.repository) : super(ExerciseInitial());

  @override
  Future<void> getBodyPartExerciseLibrary({required String part, required int templateID}) async {
    emit(ExerciseLoadingState());
    final result = await repository.getBodyPartExerciseLibrary(part: part, templateID: templateID);
    result.fold(
        (failure) => emit(const ExerciseErrorState('Failed to fetch exercises')),
        (exercises) {
      if (exercises.isEmpty) {
        print('empty');
        emit(ExerciseEmptyState());
        return;
      }
      emit(ExerciseLoadedState(exercises.cast<ExerciseLibrary>()));
    });
  }

  @override
  Future<void> addExerciseToPlan(ExerciseDay exerciseDay) async {
    emit(ExerciseDayLoadingState());
    final result = await repository.addExerciseToPlan(exerciseDay);
    result.fold(
        (failure) => emit(const ExerciseErrorState('Failed to add exercise')),
        (exercise) {emit(ExerciseAddedState(exercise));
    });
  }

  @override
  Future<void> removeExerciseFromPlan({required int exerciseID, required String day, required int templateID}) async {
    emit(ExerciseDayLoadingState());
    final result = await repository.removeExerciseFromPlan(exerciseID: exerciseID, day: day, templateID: templateID);
    result.fold(
            (failure) => emit(const ExerciseErrorState('Failed to remove exercise')),
            (exercise) {emit(ExerciseRemovedState());
    });
  }



}