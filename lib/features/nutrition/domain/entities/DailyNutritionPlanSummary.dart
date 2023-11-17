import 'package:equatable/equatable.dart';

class DailyNutritionPlanSummary extends Equatable {
  final int? id;
  final double totalCarbs;
  final double totalProtein;
  final double totalFat;
  final double totalCalories;

  const DailyNutritionPlanSummary({
    this.id,
    required this.totalCarbs,
    required this.totalProtein,
    required this.totalFat,
    required this.totalCalories,
  });

  @override
  List<Object?> get props => [
    id,
    totalCarbs,
    totalProtein,
    totalFat,
    totalCalories,
  ];

  // copyWith method
  DailyNutritionPlanSummary copyWith({
    int? id,
    double? totalCarbs,
    double? totalProtein,
    double? totalFat,
    double? totalCalories,
  }) {
    return DailyNutritionPlanSummary(
      id: id ?? this.id,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalProtein: totalProtein ?? this.totalProtein,
      totalFat: totalFat ?? this.totalFat,
      totalCalories: totalCalories ?? this.totalCalories,
    );
  }
}