import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
class NutritionPlanMealModel extends NutritionPlanMeal {
  const NutritionPlanMealModel({
    int? id,
    int? nutrition_plan_id,
    int? meal_id,
    String? day,
    int? size,
    String? meal_name,
    double? calories,
    double? fat,
    double? protein,
    double? carbs,
  }) : super(
    id: id,
    nutrition_plan_id: nutrition_plan_id,
    meal_id: meal_id,
    day: day,
    size: size,
    meal_name: meal_name,
    calories: calories,
    fat: fat,
    protein: protein,
    carbs: carbs,
  );

  factory NutritionPlanMealModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanMealModel(
      id: json['id'],
      meal_name: json['name'],
      calories: double.parse(json['calories'].toString()),
      size: json['size'],
      fat: double.parse(json['fat'].toString()),
      protein: double.parse(json['protein'].toString()),
      carbs: double.parse(json['carbs'].toString()),
      day: json['day'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'nutrition_plan_id': nutrition_plan_id.toString(),
      'meal_id': meal_id.toString(),
      'day': day.toString(),
      'size': size.toString(),
    };
  }

  factory NutritionPlanMealModel.fromEntity(NutritionPlanMeal nutritionPlanMeal) {
    return NutritionPlanMealModel(
      id: nutritionPlanMeal.id,
      nutrition_plan_id: nutritionPlanMeal.nutrition_plan_id,
      meal_id: nutritionPlanMeal.meal_id,
      day: nutritionPlanMeal.day,
      size: nutritionPlanMeal.size,
      meal_name: nutritionPlanMeal.meal_name,
      calories: nutritionPlanMeal.calories,
      fat: nutritionPlanMeal.fat,
      protein: nutritionPlanMeal.protein,
      carbs: nutritionPlanMeal.carbs,

    );
  }

  NutritionPlanMeal toEntity() {
    return NutritionPlanMeal(
      id: id,
      nutrition_plan_id: nutrition_plan_id,
      meal_id: meal_id,
      day: day,
      size: size,
      meal_name: meal_name,
      calories: calories,
      fat: fat,
      protein: protein,
      carbs: carbs,
    );
  }
}