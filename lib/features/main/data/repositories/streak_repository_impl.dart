
import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/main/domain/repositories/streak_repository.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';


class StreakRepositoryImpl extends StreakRepository{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  StreakRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> getStreak() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStreak = await remoteDataSource.getStreak();
        localDataSource.cacheStreak(remoteStreak);
        return Right(remoteStreak);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localStreak = await localDataSource.getCachedStreak();
        return Right(localStreak);
      } on EmptyCacheException catch (e) {
        return Left(EmptyCacheFailure(message: e.message));
      }
    }
  }
}