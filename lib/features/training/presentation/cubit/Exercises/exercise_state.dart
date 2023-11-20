part of 'exercise_cubit.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoadingState extends ExerciseState {}

class ExerciseLoadedState extends ExerciseState {
  final List<ExerciseLibrary> exercises;

  const ExerciseLoadedState(this.exercises);

  @override
  List<Object> get props => [exercises];
}

class ExerciseEmptyState extends ExerciseState {}

class ExerciseErrorState extends ExerciseState {
  final String message;

  const ExerciseErrorState(this.message);

  @override
  List<Object> get props => [message];
}
