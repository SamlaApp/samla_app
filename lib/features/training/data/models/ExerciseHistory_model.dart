import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';

class ExerciseHistoryModel extends ExerciseHistory {
  const ExerciseHistoryModel({
    required super.id,
    required super.exercise_library_id,
    required super.sets,
    required super.duration,
    required super.repetitions,
    required super.weight,
    required super.distance,
    required super.notes,
    required super.day,
  });

  factory ExerciseHistoryModel.fromJson(Map<String, dynamic> json) {
    // Helper function to parse integers safely
    int? parseInt(dynamic value) {
      if (value is int) {
        return value;
      } else if (value is String) {
        return int.tryParse(value);
      }
      return null;
    }

    // Helper function to parse doubles safely
    double? parseDouble(dynamic value) {
      if (value is double) {
        return value;
      } else if (value is int) {
        return value.toDouble();
      } else if (value is String) {
        return double.tryParse(value);
      }
      return null;
    }

    // Extract values safely, providing default values or handling nulls
    final int id =
        parseInt(json['id']) ?? 0; // Default to 0 if id is not parsable
    final int exerciseLibraryId = parseInt(json['exercise_library_id']) ?? 0;
    final int sets = parseInt(json['sets']) ?? 0;
    final int duration = parseInt(json['duration']) ?? 0;
    final int repetitions = parseInt(json['repetitions']) ?? 0;
    final double weight = parseDouble(json['weight']) ?? 0.0;
    final double distance = parseDouble(json['distance']) ?? 0.0;
    final String notes = json['notes']?.toString() ?? 'No notes';

    // Assuming 'created_at' can be used as the 'day' field
    final String day = json['date']?.toString() ?? '';

    return ExerciseHistoryModel(
      id: id,
      exercise_library_id: exerciseLibraryId,
      sets: sets,
      duration: duration,
      repetitions: repetitions,
      weight: weight,
      distance: distance,
      notes: notes,
      day: day,
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
