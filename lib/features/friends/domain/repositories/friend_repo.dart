import '../../../../core/error/failures.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/friends_model.dart';
import 'package:dartz/dartz.dart';

abstract class FriendRepository {
  Future<Either<Failure, FriendsModel>> addFriend(int friendId);

  Future<Either<Failure, List<UserModel>>> getFriends();

  Future<Either<Failure, FriendsModel>> getFriendshipStatus(int friendId);

  Future<Either<Failure, FriendsModel>> acceptFriend(int id);

  Future<Either<Failure, FriendsModel>> rejectFriend(int id);
}
