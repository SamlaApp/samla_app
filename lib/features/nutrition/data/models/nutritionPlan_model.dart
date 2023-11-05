import '../../domain/entities/nutritionPlan.dart';

class NutritionPlanModel extends NutritionPlan {
  const NutritionPlanModel({
    required super.id,
    required super.name,
    required super.type,
    required super.calories,
    required super.start_time,
    required super.end_time,
  });

  @override
  factory NutritionPlanModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      calories: json['calories'],
      start_time: json['start_time'],
      end_time: json['end_time'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'type': type,
      'calories': calories.toString(),
      'start_time': start_time!,
      'end_time': end_time!,
    };
  }

  factory NutritionPlanModel.fromEntity(NutritionPlan entity) {
    return NutritionPlanModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      calories: entity.calories,
      start_time: entity.start_time,
      end_time: entity.end_time,
    );
  }

}
