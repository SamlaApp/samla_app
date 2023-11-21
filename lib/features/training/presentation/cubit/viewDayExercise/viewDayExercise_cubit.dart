import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';
import 'package:samla_app/features/training/domain/repositories/exercise_repository.dart';
part 'viewDayExercise_state.dart';

class ViewDayExerciseCubit extends Cubit<ViewDayExerciseState> {
  final ExerciseRepository repository;

  ViewDayExerciseCubit(this.repository) : super(ViewDayExerciseInitial());

  @override
  Future<void> getExercisesDay({required String day, required int templateID}) async {
    emit(ExercisesDayLoadingState());
    final result = await repository.getExercisesDay(
        day: day, templateID: templateID);
    result.fold(
            (failure) =>
            emit(const ExerciseDayErrorState('Failed to fetch exercises')),
            (exercises) {
          if (exercises.isEmpty) {
            print('empty');
            emit(ExerciseDayEmptyState());
            return;
          }
          emit(ExerciseDayLoadedState(exercises.cast<ExerciseLibrary>()));
        });
  }

}