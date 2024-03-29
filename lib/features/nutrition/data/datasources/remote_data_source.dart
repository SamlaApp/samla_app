import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/nutrition/data/models/DailyNutritionPlanSummary_model.dart';
import 'package:samla_app/features/nutrition/data/models/MealLibrary_model.dart';
import 'package:samla_app/features/nutrition/data/models/NutritionPlanMeal_model.dart';
import 'package:samla_app/features/nutrition/data/models/NutritionPlanStatus_model.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';

import 'package:http/http.dart' as http;
import 'package:samla_app/features/nutrition/domain/entities/DailyNutritionPlanSummary.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';

import 'package:samla_app/core/network/samlaAPI.dart';

abstract class NutritionPlanRemoteDataSource {
  Future<List<NutritionPlan>> getAllNutritionPlans();
  Future<NutritionPlanModel> createNutritionPlan(NutritionPlan nutritionPlan);
  Future<MealLibraryModel> searchMealLibrary(String query);
  Future<MealLibraryModel> addMealLibrary(MealLibrary mealLibrary);
  Future<NutritionPlanMeal> addNutritionPlanMeal(
      NutritionPlanMeal nutritionPlanMeal);
  Future<List<NutritionPlanMeal>> getNutritionPlanMeals(String query, int id);
  Future<Either<Failure, Unit>> deleteNutritionPlanMeal(int id);
  Future<Either<Failure, Unit>> deleteNutritionPlan(int id);
  Future<List<NutritionPlan>> getTodayNutritionPlan(String query);
  Future<NutritionPlanStatus> getNutritionPlanStatus(int id);
  Future<NutritionPlanStatus> updateNutritionPlanStatus(
      NutritionPlanStatus nutritionPlanStatus);
  Future<DailyNutritionPlanSummary> getDailyNutritionPlanSummary();
  Future<Either<Failure, Unit>> setCustomCalories(int calories);
}

class NutritionPlanRemoteDataSourceImpl
    implements NutritionPlanRemoteDataSource {
  final http.Client client;

  NutritionPlanRemoteDataSourceImpl({required this.client});

   

  @override
  Future<List<NutritionPlan>> getAllNutritionPlans() async {
    final res = await samlaAPI(endPoint: '/nutrition/get', method: 'GET');
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      final decodedNutritionPlans = json.decode(resBody)['nutrition_plans'];

      final List<NutritionPlanModel> convertedPlans = [];

      for (var nutritionPlan in decodedNutritionPlans) {
        convertedPlans.add(NutritionPlanModel.fromJson(nutritionPlan));
      }
      return convertedPlans;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<NutritionPlanModel> createNutritionPlan(
      NutritionPlan nutritionPlan) async {
    final nutrition = NutritionPlanModel.fromEntity(nutritionPlan);
    final response = await samlaAPI(
      data: nutrition.toJson(),
      endPoint: '/nutrition/create',
      method: 'POST',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final NutritionPlanModel nutritionPlan =
          NutritionPlanModel.fromJson(json.decode(resBody)['nutrition_plan'][0]);
      return nutritionPlan;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<MealLibraryModel> searchMealLibrary(String query) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/search/$query',
      method: 'GET',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final MealLibraryModel mealLibrary =
          MealLibraryModel.fromJson(json.decode(resBody)['meal']);
      return mealLibrary;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<MealLibraryModel> addMealLibrary(MealLibrary mealLibrary) async {
    final meal = MealLibraryModel.fromEntity(mealLibrary);
    final response = await samlaAPI(
      data: meal.toJson(),
      endPoint: '/nutrition/food/create',
      method: 'POST',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final MealLibraryModel mealLibrary =
          MealLibraryModel.fromJson(json.decode(resBody)['meal']);
      return mealLibrary;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<NutritionPlanMeal> addNutritionPlanMeal(
      NutritionPlanMeal nutritionPlanMeal) async {
    final meal = NutritionPlanMealModel.fromEntity(nutritionPlanMeal);

    final response = await samlaAPI(
      endPoint: '/nutrition/plan/add',
      method: 'POST',
      data: meal.toJson(),
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final NutritionPlanMealModel nutritionPlanMeal =
          NutritionPlanMealModel.fromJson(json.decode(resBody)['user_meal']);
      return nutritionPlanMeal;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<NutritionPlanMeal>> getNutritionPlanMeals(
      String query, int id) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/plan/get/$query/$id',
      method: 'GET',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final List<dynamic> nutritionPlanMeals =
          json.decode(resBody)['nutrition_plan'];
      final List<NutritionPlanMealModel> convertedPlans = nutritionPlanMeals
          .map(
              (e) => NutritionPlanMealModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedPlans;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNutritionPlanMeal(
      int id) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/plan/remove',
      method: 'POST',
      data: {'user_meal_id': '$id'},
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return const Right(unit);
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNutritionPlan(int id) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/delete',
      method: 'POST',
      data: {'nutrition_plan_id': '$id'},
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return const Right(unit);
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<NutritionPlan>> getTodayNutritionPlan(String query) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/plan/get_today/$query',
      method: 'GET',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final List<dynamic> nutritionPlans =
          json.decode(resBody)['nutrition_plan'];
      final List<NutritionPlanModel> convertedPlans = nutritionPlans
          .map((e) => NutritionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedPlans;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<NutritionPlanStatus> getNutritionPlanStatus(int id) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/plan/status/get/$id',
      method: 'GET',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final NutritionPlanStatusModel nutritionPlanStatus =
          NutritionPlanStatusModel.fromJson(json.decode(resBody)['status']);
      return nutritionPlanStatus;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<NutritionPlanStatus> updateNutritionPlanStatus(
      NutritionPlanStatus nutritionPlanStatus) async {
    final status = NutritionPlanStatusModel.fromEntity(nutritionPlanStatus);
    final response = await samlaAPI(
      data: status.toJson(),
      endPoint: '/nutrition/plan/status/set',
      method: 'POST',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final NutritionPlanStatusModel nutritionPlanStatus =
          NutritionPlanStatusModel.fromJson(json.decode(resBody)['status']);
      return nutritionPlanStatus;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<DailyNutritionPlanSummary> getDailyNutritionPlanSummary() async {
    final response = await samlaAPI(
      endPoint: '/nutrition/summary/get',
      method: 'GET',
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final DailyNutritionPlanSummaryModel dailyNutritionPlanSummary =
          DailyNutritionPlanSummaryModel.fromJson(
              json.decode(resBody)['nutrition_plan']);
      return dailyNutritionPlanSummary;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Either<Failure, Unit>> setCustomCalories(int calories) async {
    final response = await samlaAPI(
      endPoint: '/nutrition/custom_calories/set',
      method: 'POST',
      data: {'calories': '$calories'},
    );
    final resBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return const Right(unit);
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }
}
