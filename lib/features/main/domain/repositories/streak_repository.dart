import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';

abstract class StreakRepository {
  Future<Either<Failure, int>> getStreak();
}