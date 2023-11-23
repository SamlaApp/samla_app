import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<ExerciseHistory>>> getHistory({required int id});

  Future<Either<Failure, ExerciseHistory>> addHistory(
      {required int set,
      required int duration,
      required int repetitions,
      required int weight,
      required double distance,
      required String notes,
      required int exercise_library_id});
}
