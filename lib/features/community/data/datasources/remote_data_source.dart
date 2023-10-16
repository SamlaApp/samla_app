import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/data/models/Community.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, List<CommunityModel>>> getAllCommunities();

  Future<Either<Failure, List<CommunityModel>>> getMyCommunities();

  Future<Either<Failure, CommunityModel>> createCommunity(
      {required CommunityModel community});

  Future<Either<Failure, CommunityModel>> updateCommunity(
      {required int communityID});

  Future<Either<Failure, Unit>> deleteCommunity({required int communityID});

  Future<Either<Failure, Unit>> joinCommunity({required int communityID});

  Future<Either<Failure, Unit>> leaveCommunity({required int communityID});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
 
      
        @override
        Future<Either<Failure, Unit>> deleteCommunity({required int communityID}) {
          // TODO: implement deleteCommunity
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, List<CommunityModel>>> getAllCommunities() {
          // TODO: implement getAllCommunities
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, List<CommunityModel>>> getMyCommunities() {
          // TODO: implement getMyCommunities
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, Unit>> joinCommunity({required int communityID}) {
          // TODO: implement joinCommunity
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, Unit>> leaveCommunity({required int communityID}) {
          // TODO: implement leaveCommunity
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, CommunityModel>> updateCommunity({required int communityID}) {
          // TODO: implement updateCommunity
          throw UnimplementedError();
        }
        
          @override
          Future<Either<Failure, CommunityModel>> createCommunity({required CommunityModel community}) {
            // TODO: implement createCommunity
            throw UnimplementedError();
          }
      }

