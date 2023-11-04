import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';

import 'package:samla_app/features/nutrition/data/datasources/local_datasource.dart';
import 'package:samla_app/features/nutrition/data/datasources/remote_data_source.dart';

import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';

import '../models/nutritionPlan_model.dart';

class NutritionPlanRepositoryImpl implements NutritionPlanRepository {
  final NutritionPlanRemoteDataSource remoteDataSource;
  final NutritionPlanLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NutritionPlanRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<NutritionPlan>>> getAllNutritionPlans() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNutritionPlans = await remoteDataSource.getAllNutritionPlans();
        localDataSource.cacheNutritionPlans(remoteNutritionPlans as List<NutritionPlanModel>);
        return Right(remoteNutritionPlans);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localNutritionPlans = await localDataSource.getCachedNutritionPlans();
        return Right(localNutritionPlans);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }


}