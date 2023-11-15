import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/data/datasources/community_admin_remote_data_source.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';
import 'package:samla_app/features/community/domain/entities/community.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';

class CommunityAdminRepositoryImpl implements CommunityAdminRepository {
  final CommunityAdminRemoteDataSource remoteDataSource;

  CommunityAdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> acceptJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement acceptJoinRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RequestToJoin>>> getJoinRequests(
      {required int communityID}) async {
    try {
      final requests =
          await remoteDataSource.getJoinRequests(communityID: communityID);
      return Right(requests);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> rejectJoinRequest(
      {required int communityID, required int userID}) {
    // TODO: implement rejectJoinRequest
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> deleteUser({required int communityID, required int userID})async {
    try{
      final res = await remoteDataSource.deleteUser(communityID, userID);
      return Right(unit);
    }
    on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
