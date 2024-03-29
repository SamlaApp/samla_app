import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/community/data/datasources/community_local_datasource.dart';
import 'package:samla_app/features/community/data/datasources/community_remote_data_source.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;
  final CommunityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CommunityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Community>>> getAllCommunities() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCommunities = await remoteDataSource.getAllCommunities();
        return Right(remoteCommunities);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }


  @override
  Future<Either<Failure, Community>> createCommunity(
      {required Community community}) async{
    if (await networkInfo.isConnected) {
      try {
        final  newCommunity = await remoteDataSource.createCommunity(community);
        return Right(newCommunity);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
      }
  }

  @override
  Future<Either<Failure, Unit>> deleteCommunity({required int communityID}) async{
     if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCommunity(communityID: communityID);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<List<Community>>>> getMyCommunities() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCommunities = await remoteDataSource.getMyCommunities();
        localDataSource.cacheCommunities(remoteCommunities);
        return Right(remoteCommunities);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localCommunities = await localDataSource.getCachedCommunities();
        return Right(localCommunities);
      } on EmptyCacheException catch (e) {
        return Left(EmptyCacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> joinCommunity({required int communityID}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.joinCommunity(communityID: communityID);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> leaveCommunity({required int communityID}) async{
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.leaveCommunity(communityID: communityID);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Community>> updateCommunity(
      Community community, bool updateHandle) async  {
    if (await networkInfo.isConnected) {
      try {
        final  updatedCommunity = await remoteDataSource.updateCommunity(community, updateHandle);
        return Right(updatedCommunity);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
      }
  }
  
  @override
  Future<Either<Failure, int>> getCommunityMemebersNumber({required int communityID}) async {
    if (await networkInfo.isConnected) {
      try {
        final  totalNumbers = await remoteDataSource.getCommunityMemebersNumber(communityID: communityID);
        return Right(totalNumbers);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
      }
  }
  
  @override
  Future<Either<Failure, List<Community>>> searchCommunities(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final  communities = await remoteDataSource.searchCommunities(query);
        return Right(communities);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getCommunityMemebers(int communityID, bool isPublic)async {
    if (await networkInfo.isConnected) {
      try {
        final  users = await remoteDataSource.getCommunityMemebers(communityID, isPublic);
        return Right(users);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
