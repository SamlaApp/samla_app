import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../domain/repositories/friend_repo.dart';

part 'friends_state.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit(this.repository) : super(FriendInitial());
  final FriendRepository repository;

  // for search
  List<User> allFriends = []; // Store all friends
  // getFriends with storing all friends

  // addFriend
  Future<void> addFriend(int friendId) async {
    // emit(FriendLoading());
    bool isAdded = false;
    final result = await repository.addFriend(friendId);
    result.fold((l) => emit(FriendError(message: l.message)), (status) {
      isAdded = true;
    });
    if (isAdded) {
      await getFriends(); //refreash firends list
    }
  }

  // getFriends with storing all friends
  Future<void> getFriends() async {
    emit(FriendLoading());
    final result = await repository.getFriends();
    result.fold(
      (l) => emit(FriendError(message: l.message)),
      (friends) {
        allFriends = friends; // Store all friends
        emit(FriendLoaded(friends: friends));
      },
    );
  }

  // acceptFriend
  Future<void> acceptFriend(int id) async {
    emit(FriendLoading());
    bool isAdded = false;
    final result = await repository.acceptFriend(id);
    result.fold((l) => emit(FriendError(message: l.message)), (status) {
      isAdded = true;
    });
    if (isAdded) {
      await getFriends(); //refreash firends list
    }
  }

  // rejectFriend
  Future<void> rejectFriend(int id) async {
    emit(FriendLoading());
    bool isRejected = false;
    final result = await repository.rejectFriend(id);
    result.fold((l) => emit(FriendError(message: l.message)), (status) {
      isRejected = true;
    });
    if (isRejected) {
      await getFriends(); //refreash firends list
    }
  }


  bool isExistInList(String id) {
    for (var friend in allFriends) {
      if (id == friend.id) {
        return true;
      }
    }
    return false;
  }
}
