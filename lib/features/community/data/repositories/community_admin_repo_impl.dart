import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/data/datasources/community_admin_remote_data_source.dart';
import 'package:samla_app/features/community/domain/entities/community.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';

class CommunityAdminRepositoryImpl implements CommunityAdminRepository {
  final CommunityAdminRemoteDataSource remoteDataSource;

  CommunityAdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> acceptJoinRequest({required int communityID, required int userID}) {
    // TODO: implement acceptJoinRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> getJoinRequests({required int communityID}) {
    // TODO: implement getJoinRequests
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> rejectJoinRequest({required int communityID, required int userID}) {
    // TODO: implement rejectJoinRequest
    throw UnimplementedError();
  }

}
