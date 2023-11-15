import 'package:equatable/equatable.dart';

class NutritionPlan extends Equatable {
  final int? id;
  final String name;
  final String type;
  final String? start_time;
  final String? end_time;

  const NutritionPlan({
    this.id,
    required this.name,
    required this.type,
    required this.start_time,
    required this.end_time,
  });


  @override
  List<Object?> get props => [id, name, type, start_time, end_time];


  NutritionPlan copyWith({
    int? id,
    String? name,
    String? type,
    String? start_time,
    String? end_time,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
    );
  }

}