
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';

class NutritionPlanStatusModel extends NutritionPlanStatus {
  final int? id;
  final int nutritionPlanStatusId;
  final String status;

  const NutritionPlanStatusModel({
    this.id,
    required this.nutritionPlanStatusId,
    required this.status,
  }) : super(
    id: id,
    nutritionPlanStatusId: nutritionPlanStatusId,
    status: status,
  );

  factory NutritionPlanStatusModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanStatusModel(
      id: json['id'],
      nutritionPlanStatusId: json['nutrition_plan_id'] as int,
      status: json['status'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'nutrition_plan_id': nutritionPlanStatusId.toString(),
      'status': status,
    };
  }

  factory NutritionPlanStatusModel.fromEntity(NutritionPlanStatus entity) {
    return NutritionPlanStatusModel(
      id: entity.id,
      nutritionPlanStatusId: entity.nutritionPlanStatusId,
      status: entity.status,
    );
  }

}

