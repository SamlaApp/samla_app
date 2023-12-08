import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/friend_repo.dart';
import '../datasources/remoteDataSource.dart';
import '../datasources/localDataSource.dart';
import '../models/friends_model.dart';

class FriendRepositoryImpl extends FriendRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FriendRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  //addFriend
  @override
  Future<Either<Failure, FriendsModel>> addFriend(int friendId) async {
    try {
      final friends = await remoteDataSource.addFriend(friendId);
      return Right(friends);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  //getFriends
  @override
  Future<Either<Failure, List<UserModel>>> getFriends() async {
    if (await networkInfo.isConnected) {
      try {
        final friends = await remoteDataSource.getFriends();
        return Right(friends);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  //getFriendshipStatus
  @override
  Future<Either<Failure, FriendsModel>> getFriendshipStatus(
      int friendId) async {
    try {
      final friends = await remoteDataSource.getFriendshipStatus(friendId);
      return Right(friends);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  //acceptFriend
  @override
  Future<Either<Failure, FriendsModel>> acceptFriend(int id) async {
    try {
      final friends = await remoteDataSource.acceptFriend(id);
      return Right(friends);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  //rejectFriend
  @override
  Future<Either<Failure, FriendsModel>> rejectFriend(int id) async {
    try {
      final friends = await remoteDataSource.rejectFriend(id);
      return Right(friends);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
