// class CommunityRepositoryImpl implements CommunityRepository {
//   final CommunityRemoteDataSource remoteDataSource;
//   final CommunityLocalDataSource localDataSource;
//   final NetworkInfo networkInfo;

//   CommunityRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, List<Community>>> getCommunities() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final remoteCommunities = await remoteDataSource.getCommunities();
//         localDataSource.cacheCommunities(remoteCommunities);
//         return Right(remoteCommunities);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       try {
//         final localCommunities = await localDataSource.getLastCommunities();
//         return Right(localCommunities);
//       } on CacheException {
//         return Left(CacheFailure());
//       }
//     }
//   }
// }