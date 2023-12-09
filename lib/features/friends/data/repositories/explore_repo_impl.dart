import 'package:dartz/dartz.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/explore_repo.dart';
import '../datasources/localDataSource.dart';
import '../datasources/remoteDataSource.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ExploreRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  //searchExplore
  @override
  Future<Either<Failure, List<User>>> searchExplore(String query) async {
    try {
      final users = await remoteDataSource.searchExplore(query);
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
