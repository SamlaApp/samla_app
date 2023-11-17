import 'package:equatable/equatable.dart';

class NutritionPlanStatus extends Equatable {
  final int? id;
  final int nutritionPlanStatusId;
  final String status;

  const NutritionPlanStatus({
    this.id,
    required this.nutritionPlanStatusId,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        nutritionPlanStatusId,
        status,
      ];

  NutritionPlanStatus copyWith({
    int? id,
    int? nutritionPlanStatusId,
    String? status,
  }) {
    return NutritionPlanStatus(
      id: id ?? this.id,
      nutritionPlanStatusId:
          nutritionPlanStatusId ?? this.nutritionPlanStatusId,
      status: status ?? this.status,
    );
  }
}
