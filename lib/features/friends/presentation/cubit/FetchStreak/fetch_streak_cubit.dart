import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/friends/domain/repositories/friend_repo.dart';

part 'fetch_streak_state.dart';

class FetchStreakCubit extends Cubit<FetchStreakState> {
  FetchStreakCubit(this.repository) : super(FetchStreakInitial());
  final FriendRepository repository;

  Future<void> getStreak(int friendId) async {
    final result = await repository.getFriendStreak(friendId);
    print(result);
    return result.fold((l) => 0, (r) => emit(FetchStreakInitial(r)));
  }
}
