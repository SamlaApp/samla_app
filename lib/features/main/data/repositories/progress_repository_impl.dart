import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/main/data/models/Progress.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
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
        var remoteProgress = await remoteDataSource.getAllProgress();
        remoteProgress = _helperFilter(remoteProgress);
        // print('remoteProgress: $remoteProgress');
        localDataSource.cacheProgress(remoteProgress);
        return Right(remoteProgress);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } 
      catch (e) {
        print(e.toString());
        return Left(ServerFailure(message: e.toString()));
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

  @override
  Future<Either<Failure, Unit>> sendProgress(Progress progress) async {
    if (await networkInfo.isConnected) {
      try {
        final req = await remoteDataSource
            .sendProgress(ProgressModel.fromEntity(progress));
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

//return only the last progress from each day
  List<ProgressModel> _helperFilter(List<ProgressModel> unFiltred) {
    // reorder the list newer will be first element,oldest will be the last by their date
    unFiltred.sort((a, b) => b.date!.compareTo(a.date!));
    final filtered = <ProgressModel>[];
    final dates = <String>[];

    for (var item in unFiltred) {
      var itemDate = '${item.date!.year}-${item.date!.month}-${item.date!.day}';
      if (!dates.contains(itemDate)) {
        dates.add(itemDate);
        filtered.add(item);
      }
    }
    return filtered.reversed.toList();
  }
  
  @override
  Future<Either<Failure, List<Progress>>> getFriendProgress(int friendID) async{
    if (await networkInfo.isConnected) {
      try {
        var remoteProgress = await remoteDataSource.getFriendProgress(friendID);
        // print('remoteProgress: $remoteProgress');
        return Right(remoteProgress);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } 
      catch (e) {
        // print(e.toString());
        return Left(ServerFailure(message: e.toString()));
      }
    } else{
      return Left(ServerFailure(message: 'No Internet Connection'));
    }
  }


}
