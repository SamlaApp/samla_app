import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../data/models/friends_model.dart';
import '../../../domain/repositories/friend_repo.dart';

part 'friends_state.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit(this.repository) : super(FriendInitial());
  final FriendRepository repository;

  // for search
  List<UserModel> allFriends = []; // Store all friends
  // getFriends with storing all friends

  // addFriend
  Future<void> addFriend(int friendId) async {
    emit(FriendLoading());
    final result = await repository.addFriend(friendId);
    result.fold((l) => emit(FriendError(message: l.message)), (friends) {
      emit(FriendLoaded(friends: friends));
    });
  }

  // getFriends
  // getFriends with storing all friends
  Future<void> getFriends() async {
    emit(FriendLoading());
    final result = await repository.getFriends();
    result.fold(
      (l) => emit(FriendError(message: l.message)),
      (friends) {
        allFriends = friends; // Store all friends
        emit(FriendListLoaded(friends: friends));
      },
    );
  }

  // getFriendshipStatus
  Future<void> getFriendshipStatus(int friendId) async {
    emit(FriendShipLoading());
    final result = await repository.getFriendshipStatus(friendId);
    result.fold((l) => emit(FriendError(message: l.message)), (friends) {
      emit(FriendShipLoaded(friends: friends));
    });
  }

  // acceptFriend
  Future<void> acceptFriend(int id) async {
    emit(FriendShipLoading());
    final result = await repository.acceptFriend(id);
    result.fold((l) => emit(FriendError(message: l.message)), (friends) {
      emit(FriendShipLoaded(friends: friends));
    });
  }

  // rejectFriend
  Future<void> rejectFriend(int id) async {
    emit(FriendShipLoading());
    final result = await repository.rejectFriend(id);
    result.fold((l) => emit(FriendError(message: l.message)), (friends) {
      emit(FriendShipLoaded(friends: friends));
    });
  }

  // searchFriend

  void searchFriends(String query) {
    if (query.isEmpty) {
      emit(FriendListLoaded(
          friends: allFriends)); // Show all friends if query is empty
      return;
    }

    final filteredFriends = allFriends.where((friend) {
      return friend.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(FriendListLoaded(friends: filteredFriends));
  }
}
