import '../../domain/entities/nutritionPlan.dart';

class NutritionPlanModel extends NutritionPlan {
  const NutritionPlanModel({
    super.id,
    required super.name,
    required super.type,
    required super.start_time,
    required super.end_time,
  });

  @override
  factory NutritionPlanModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: json['name'],
      type: json['type'],
      start_time: json['start_time'],
      end_time: json['end_time'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'type': type,
      'start_time': start_time!,
      'end_time': end_time!,
    };
  }

  factory NutritionPlanModel.fromEntity(NutritionPlan entity) {
    return NutritionPlanModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      start_time: entity.start_time,
      end_time: entity.end_time,
    );
  }

}
