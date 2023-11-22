
part of 'streak_cubit.dart';

abstract class StreakState extends Equatable {
  const StreakState();

  @override
  List<Object> get props => [];
}

class StreakInitial extends StreakState {}

class StreakLoadingState extends StreakState {}

class StreakLoadedState extends StreakState {
  final int streak;

  StreakLoadedState(this.streak);
}

class StreakErrorState extends StreakState {
  final String message;

  StreakErrorState(this.message);
}