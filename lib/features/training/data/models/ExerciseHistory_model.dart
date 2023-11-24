import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';

class ExerciseHistoryModel extends ExerciseHistory {
  final String day; // Change the type to String

  const ExerciseHistoryModel({
    required this.day,
    required super.id,
    required super.exercise_library_id,
    required super.sets,
    required super.duration,
    required super.repetitions,
    required super.weight,
    required super.distance,
    required super.notes,
  });

  factory ExerciseHistoryModel.fromJson(Map<String, dynamic> json) {
    int? parseInt(dynamic value) {
      if (value is int) {
        return value;
      } else if (value is double) {
        return value.toInt(); // Convert double to int
      }
      return null; // Return null for non-numeric values
    }

    final durationValue = json['duration'];
    final duration = durationValue is int
        ? durationValue
        : (durationValue is double ? durationValue.toInt() : null);

    final weight = json['weight'] is int
        ? json['weight'].toDouble() // Convert int to double
        : (json['weight'] is double ? json['weight'] : null);

    final distance = json['distance'] is int
        ? json['distance'].toDouble() // Convert int to double
        : (json['distance'] is double ? json['distance'] : null);

    final day = json['date'] as String;

    return ExerciseHistoryModel(
      id: json['id'],
      exercise_library_id: json['exercise_library_id'],
      sets: json['sets'],
      duration: duration,
      repetitions: json['repetitions'],
      weight: weight,
      distance: distance,
      notes: json['notes'] != null ? json['notes'].toString() : 'No notes',
      day: day, // Include the 'day' field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise_library_id': exercise_library_id,
      'sets': sets,
      'duration': duration,
      'repetitions': repetitions,
      'weight': weight,
      'distance': distance,
      'notes': notes,
      'day': day, // Include the 'day' field
    };
  }
}
