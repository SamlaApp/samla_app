import 'package:equatable/equatable.dart';

class NutritionPlanMeal extends Equatable {
  final int? id;
  final int? nutrition_plan_id;
  final int? meal_id;
  final String? day;
  final int? size;
  final String? meal_name;
  final double? calories;
  final double? fat;
  final double? protein;
  final double? carbs;

  const NutritionPlanMeal({
    this.id,
    this.nutrition_plan_id,
    this.meal_id,
    this.day,
    this.size,
    this.meal_name,
    this.calories,
    this.fat,
    this.protein,
    this.carbs,
  });

  @override
  List<Object?> get props => [
        id,
        day,
        size,
        meal_name,
        calories,
        fat,
        protein,
        carbs,
      ];

  NutritionPlanMeal copyWith({
    int? id,
    int? nutrition_plan_id,
    int? meal_id,
    String? day,
    int? size,
  }) {
    return NutritionPlanMeal(
      id: id ?? this.id,
      nutrition_plan_id: nutrition_plan_id ?? this.nutrition_plan_id,
      meal_id: meal_id ?? this.meal_id,
      day: day ?? this.day,
      size: size ?? this.size,
    );
  }
}
