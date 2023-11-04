import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NutritionPlanLocalDataSource {
  Future<void> cacheNutritionPlans(List<NutritionPlanModel> nutritionPlans);
  Future<List<NutritionPlanModel>> getCachedNutritionPlans();
}

class NutritionPlanLocalDataSourceImpl implements NutritionPlanLocalDataSource {
  final SharedPreferences sharedPreferences;

  NutritionPlanLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<List<NutritionPlanModel>> getCachedNutritionPlans() {
    final jsonNutritionPlans = sharedPreferences.getStringList('my_nutritionPlans');
    if (jsonNutritionPlans != null) {
      // decode the json list to list of nutritionPlan models
      final nutritionPlans = jsonNutritionPlans
          .map<NutritionPlanModel>(
              (nutritionPlan) => NutritionPlanModel.fromJson(json.decode(nutritionPlan)))
          .toList();
      return Future.value(nutritionPlans);
    } else {
      throw EmptyCacheException(message: 'No cached nutritionPlans');
    }
  }

  @override
  Future<void> cacheNutritionPlans(List<NutritionPlanModel> nutritionPlans) {
    final jsonNutritionPlans = jsonEncode(nutritionPlans);
    sharedPreferences.setString('my_nutritionPlans', jsonNutritionPlans);
    return Future.value();
  }
}