
import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';

import 'package:samla_app/features/nutrition/data/datasources/local_datasource.dart';
import 'package:samla_app/features/nutrition/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';


import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';


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


  @override
  Future<Either<Failure, NutritionPlan>> createNutritionPlan({required NutritionPlan nutritionPlan}) async {
    if (await networkInfo.isConnected) {
      try {
        final newNeutritionPlan = await remoteDataSource.createNutritionPlan(nutritionPlan);
        return Right(newNeutritionPlan);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MealLibrary>> searchMealLibrary({required String query}) async {
    if (await networkInfo.isConnected) {
      try {
        final mealLibrary = await remoteDataSource.searchMealLibrary(query);
        return Right(mealLibrary);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MealLibrary>> addMealLibrary({required MealLibrary mealLibrary}) async {
    if (await networkInfo.isConnected) {
      try {
        final newMealLibrary = await remoteDataSource.addMealLibrary(mealLibrary);
        return Right(newMealLibrary);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlanMeal>> addNutritionPlanMeal({required NutritionPlanMeal nutritionPlanMeal}) async {
    if (await networkInfo.isConnected) {
      try {
        final newNutritionPlanMeal = await remoteDataSource.addNutritionPlanMeal(nutritionPlanMeal);
        return Right(newNutritionPlanMeal);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }


  @override
  Future<Either<Failure, List<NutritionPlanMeal>>> getNutritionPlanMeals({required String query,required int id}) async {
    if (await networkInfo.isConnected) {
      try {
        final nutritionPlanMeals = await remoteDataSource.getNutritionPlanMeals(query,id);
        return Right(nutritionPlanMeals);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlanMeal>> deleteNutritionPlanMeal({required int id}) async {
    if (await networkInfo.isConnected) {
      try {
        final nutritionPlanMeal = await remoteDataSource.deleteNutritionPlanMeal(id);
        return Right(nutritionPlanMeal as NutritionPlanMeal);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> deleteNutritionPlan({required int id}) async {
    if (await networkInfo.isConnected) {
      try {
        final nutritionPlan = await remoteDataSource.deleteNutritionPlan(id);
        return Right(nutritionPlan as NutritionPlan);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }



}