import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/friends/domain/entities/status.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class FriendRepository {
  Future<Either<Failure, FriendStatus>> addFriend(int friendId);

  Future<Either<Failure, List<User>>> getFriends();

  Future<Either<Failure, FriendStatus>> getFriendshipStatus(int friendId);

  Future<Either<Failure, FriendStatus>> acceptFriend(int id);

  Future<Either<Failure, FriendStatus>> rejectFriend(int id);

  Future<Either<Failure, int>> getFriendStreak(int friendId);
}
