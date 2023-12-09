import 'package:dartz/dartz.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';

import '../../../../core/error/failures.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<User>>> searchExplore(String query);
}
