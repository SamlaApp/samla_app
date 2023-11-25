import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';

abstract class ProgressRepository {
  Future<Either<Failure, List<Progress>>> getAllProgress();
  Future<Either<Failure, Unit>> sendProgress(Progress progress);
  
}