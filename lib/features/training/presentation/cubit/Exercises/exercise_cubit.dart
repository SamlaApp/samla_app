import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';
import 'package:samla_app/features/training/domain/repositories/exercise_repository.dart';
part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository repository;
  ExerciseCubit(this.repository) : super(ExerciseInitial());

  @override
  Future<void> getBodyPartExerciseLibrary({required String part}) async {
    emit(ExerciseLoadingState());
    final result = await repository.getBodyPartExerciseLibrary(part: part);
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

}