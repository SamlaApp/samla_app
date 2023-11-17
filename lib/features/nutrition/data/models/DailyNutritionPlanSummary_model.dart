import 'package:samla_app/features/nutrition/domain/entities/DailyNutritionPlanSummary.dart';

class DailyNutritionPlanSummaryModel extends DailyNutritionPlanSummary{
  const DailyNutritionPlanSummaryModel({
    required super.id,
    required super.totalCarbs,
    required super.totalProtein,
    required super.totalFat,
    required super.totalCalories,
  });

  @override
  factory DailyNutritionPlanSummaryModel.fromJson(Map<String, dynamic> json) {
    return DailyNutritionPlanSummaryModel(
      id: json['id'],
      totalCarbs: json['totalCarbs'] as double,
      totalProtein: json['totalProtein'] as double,
      totalFat: json['totalFat'] as double,
      totalCalories: json['totalCalories'] as double,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'totalCarbs': totalCarbs.toString(),
      'totalProtein': totalProtein.toString(),
      'totalFat': totalFat.toString(),
      'totalCalories': totalCalories.toString(),
    };
  }

  factory DailyNutritionPlanSummaryModel.fromEntity(DailyNutritionPlanSummary entity) {
    return DailyNutritionPlanSummaryModel(
      id: entity.id,
      totalCarbs: entity.totalCarbs,
      totalProtein: entity.totalProtein,
      totalFat: entity.totalFat,
      totalCalories: entity.totalCalories,
    );
  }
}