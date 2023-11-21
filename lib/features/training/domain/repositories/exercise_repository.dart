import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, List<ExerciseLibrary>>> getBodyPartExerciseLibrary({required String part,required int templateID});
  Future<Either<Failure, ExerciseDay>> addExerciseToPlan(ExerciseDay exerciseDay);
  Future<Either<Failure, List<ExerciseLibrary>>> getExercisesDay({required String day,required int templateID});
}