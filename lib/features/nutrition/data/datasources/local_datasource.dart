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
    final jsonNutritionPlansString =
        sharedPreferences.getString('my_nutritionPlans');
    if (jsonNutritionPlansString != null) {
      final jsonNutritionPlansList = json.decode(jsonNutritionPlansString);
      final nutritionPlans = jsonNutritionPlansList
          .map<NutritionPlanModel>(
              (nutritionPlan) => NutritionPlanModel.fromJson(nutritionPlan))
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
