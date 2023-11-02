import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressRemoteDataSource remoteDataSource;
  final ProgressLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProgressRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<Progress>>> getAllProgress() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProgress = await remoteDataSource.getAllProgress();
        localDataSource.cacheProgress(remoteProgress);
        return Right(remoteProgress);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localProgress = await localDataSource.getCachedProgress();
        return Right(localProgress);
      } on EmptyCacheException catch (e) {
        return Left(EmptyCacheFailure(message: e.message));
      }
    }
  }
}