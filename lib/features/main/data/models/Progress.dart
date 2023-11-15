import 'package:intl/intl.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';

class ProgressModel extends Progress {
  const ProgressModel({
    required super.id,
    required super.weight,
    required super.height,
    required super.steps,
    required super.calories,
    required super.date,
  });

  @override
  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'],
      weight: (json['weight'] as num).toDouble(), // Ensure it's converted to a double
      height: (json['height'] as num).toDouble(), // Ensure it's converted to a double
      steps: json['steps'],
      calories: json['calories'],
      date: DateFormat('yyyy-MM-dd').parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'height': height,
      'steps': steps,
      'calories': calories,
      'date': DateFormat('yyyy-MM-dd').format(date!),
    };
  }
}