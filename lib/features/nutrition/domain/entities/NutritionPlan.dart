import 'package:equatable/equatable.dart';

class NutritionPlan extends Equatable {
  final int? id;
  final String name;
  final String type;
  final int? calories;
  final String? start_time;
  final String? end_time;

  const NutritionPlan({
    this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.start_time,
    required this.end_time,
  });


  @override
  List<Object?> get props => [id, name, type, calories, start_time, end_time];


  NutritionPlan copyWith({
    int? id,
    String? name,
    String? type,
    int? calories,
    String? start_time,
    String? end_time,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      calories: calories ?? this.calories,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

}