import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/training/data/datasources/local_data_source.dart';
import 'package:samla_app/features/training/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';
import 'package:samla_app/features/training/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HistoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ExerciseHistory>>> getHistory({ required int id}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteExercises = await remoteDataSource.getHistory(id);
        return Right(remoteExercises);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, ExerciseHistory>> addHistory({required int set,required int duration,required int repetitions,required int weight,required int distance,required String notes,required int exercise_library_id}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteExercises = await remoteDataSource.addHistory(set: set,duration: duration,repetitions: repetitions,weight: weight,distance: distance,notes: notes,exercise_library_id: exercise_library_id);
        return Right(remoteExercises);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

}