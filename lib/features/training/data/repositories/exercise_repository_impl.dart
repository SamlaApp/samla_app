import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/training/data/datasources/local_data_source.dart';
import 'package:samla_app/features/training/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';
import 'package:samla_app/features/training/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ExerciseRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ExerciseLibrary>>> getBodyPartExerciseLibrary({required String part, required int templateID}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteExercises = await remoteDataSource.getBodyPartExerciseLibrary(part: part, templateID: templateID);
        return Right(remoteExercises);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, ExerciseDay>> addExerciseToPlan(ExerciseDay exerciseDay) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteExercises = await remoteDataSource.addExerciseToPlan(exerciseDay);
        return Right(remoteExercises);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

}
