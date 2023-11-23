import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';

class ExerciseHistoryModel extends ExerciseHistory{
  const ExerciseHistoryModel({
    required super.id,
    required super.exercise_library_id,
    required super.sets,
    required super.duration,
    required super.repetitions,
    required super.weight,
    required super.distance,
    required super.notes,
  });

  @override
  factory ExerciseHistoryModel.fromJson(Map<String, dynamic> json) {
    return ExerciseHistoryModel(
      id: json['id'],
      exercise_library_id: json['exercise_library_id'],
      sets: json['sets'],
      duration: json['duration'],
      repetitions: json['repetitions'],
      weight: json['weight'],
      distance: json['distance'],
      notes: json['notes']??'No notes',
    );
  }

  factory ExerciseHistoryModel.fromEntity(ExerciseHistory entity) {
    return ExerciseHistoryModel(
      id: entity.id,
      exercise_library_id: entity.exercise_library_id,
      sets: entity.sets,
      duration: entity.duration,
      repetitions: entity.repetitions,
      weight: entity.weight,
      distance: entity.distance,
      notes: entity.notes,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': int.parse(id.toString()).toString(),
      'exercise_library_id': exercise_library_id.toString(),
      'sets': sets.toString(),
      'duration': duration.toString(),
      'repetitions': repetitions.toString(),
      'weight': weight.toString(),
      'distance': distance.toString(),
      'notes': notes.toString(),
    };
  }


}