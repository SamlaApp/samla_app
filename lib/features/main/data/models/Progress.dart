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
      weight: (json['weight'] as num)
          .toDouble(), // Ensure it's converted to a double
      height: (json['height'] as num)
          .toDouble(), // Ensure it's converted to a double
      steps: json['steps'],
      calories: json['calories'],
      date: DateTime.parse(json['created_at']),
    );
  }

  Map<String, String> toJson() {
    print('this is to json method: ${date!.toIso8601String()}');
    return {
      'id': id.toString(),
      'weight': weight.toString(),
      'height': height.toString(),
      'steps': steps.toString(),
      'calories': calories.toString(),
      'created_at': date!.toIso8601String(),
    };
  }

  // from entity to model
  factory ProgressModel.fromEntity(Progress progress) {
    return ProgressModel(
      id: progress.id,
      weight: progress.weight,
      height: progress.height,
      steps: progress.steps,
      calories: progress.calories,
      date: progress.date,
    );
  }
}
