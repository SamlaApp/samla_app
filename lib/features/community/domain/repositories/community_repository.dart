import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<Community>>> getAllCommunities();

  Future<Either<Failure, List<Community>>> getMyCommunities();

  Future<Either<Failure, Community>> createCommunity(
      {required Community community});

  Future<Either<Failure, Unit>> joinCommunity({required int communityID});

  Future<Either<Failure, Unit>> leaveCommunity({required int communityID});

  Future<Either<Failure, Unit>> deleteCommunity({required int communityID});

  Future<Either<Failure, Community>> updateCommunity(
      {required int communityID});

  Future<Either<Failure, int>> getCommunityMemebersNumber(
      {required int communityID});

  Future<Either<Failure, List<Community>>> searchCommunities(String query);

  Future<Either<Failure, List<User>>> getCommunityMemebers(
      int communityID, bool isPublic);
}
