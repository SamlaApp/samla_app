import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/models/user_model.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<UserModel>>> searchExplore(String query);
}
