import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/main/domain/repositories/streak_repository.dart';
part 'streak_state.dart';

class StreakCubit extends Cubit<StreakState> {
  StreakCubit(this.repository) : super(StreakInitial());
  final StreakRepository repository;

  Future<void> getStreak() async {
    emit(StreakLoadingState()); // Show loading state
    final result = await repository.getStreak();
    result.fold(
      (failure) => emit(StreakErrorState('Failed to get streak')),
      (streak) => emit(StreakLoadedState(streak)),
    );
  }
}