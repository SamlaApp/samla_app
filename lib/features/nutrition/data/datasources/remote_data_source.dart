import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/nutrition/data/models/MealLibrary_model.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/core/network/samlaAPI.dart';

abstract class NutritionPlanRemoteDataSource {
  Future<List<NutritionPlan>> getAllNutritionPlans();
  Future<NutritionPlanModel> createNutritionPlan(NutritionPlan nutritionPlan);
  Future<MealLibraryModel> searchMealLibrary(String query);
}

const BASE_URL = 'https://samla.mohsowa.com/api/nutrition';

class NutritionPlanRemoteDataSourceImpl
    implements NutritionPlanRemoteDataSource {
  final http.Client client;

  NutritionPlanRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NutritionPlan>> getAllNutritionPlans() async {
    final res = await samlaAPI(endPoint: '/nutrition/get', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> nutritionPlans =
          json.decode(resBody)['nutrition_plans'];
      final List<NutritionPlanModel> convertedPlans = nutritionPlans
          .map((e) => NutritionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
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
          NutritionPlanModel.fromJson(json.decode(resBody)['nutrition_plan']);
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
}
