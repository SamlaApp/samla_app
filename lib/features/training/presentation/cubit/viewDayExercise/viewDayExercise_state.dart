part of 'viewDayExercise_cubit.dart';

abstract class ViewDayExerciseState extends Equatable {
  const ViewDayExerciseState();

  @override
  List<Object> get props => [];
}

class ViewDayExerciseInitial extends ViewDayExerciseState {}

class ExerciseDayLoadedState extends ViewDayExerciseState {
  final List<ExerciseLibrary> exercises;

  const ExerciseDayLoadedState(this.exercises);

  @override
  List<Object> get props => [exercises];
}

class ExerciseDayErrorState extends ViewDayExerciseState {
  final String message;

  const ExerciseDayErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ExerciseDayEmptyState extends ViewDayExerciseState {}

class ExerciseDayAddedState extends ViewDayExerciseState {
  final ExerciseDay exerciseDay;

  const ExerciseDayAddedState(this.exerciseDay);

  @override
  List<Object> get props => [exerciseDay];
}

class ExercisesDayLoadingState extends ViewDayExerciseState {}