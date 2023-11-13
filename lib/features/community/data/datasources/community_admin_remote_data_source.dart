import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/samlaAPI_test.dart';

abstract class CommunityAdminRemoteDataSource {
  Future<Either<Failure, Unit>> getJoinRequests({required int communityID});

  Future<Either<Failure, Unit>> acceptJoinRequest(
      {required int communityID, required int userID});

  Future<Either<Failure, Unit>> rejectJoinRequest(
      {required int communityID, required int userID});
}

class CommunityAdminRemoteDataSourceImpl
    implements CommunityAdminRemoteDataSource {
  @override
  Future<Either<Failure, Unit>> getJoinRequests({required int communityID}) {
        throw UnimplementedError();

  }

  @override
  Future<Either<Failure, Unit>> rejectJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement rejectJoinRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> acceptJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement acceptJoinRequest
    throw UnimplementedError();
  }
}
