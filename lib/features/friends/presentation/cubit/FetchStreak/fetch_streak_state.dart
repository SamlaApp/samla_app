part of 'fetch_streak_cubit.dart';

sealed class FetchStreakState extends Equatable {
  const FetchStreakState([this.streak = 0]);
  final int streak;

  @override
  List<Object> get props => [];
}

final class FetchStreakInitial extends FetchStreakState {
  const FetchStreakInitial([int streak = 0]) : super(streak);
}
