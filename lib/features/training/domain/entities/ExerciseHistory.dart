import 'package:equatable/equatable.dart';

class ExerciseDay extends Equatable {
  final int? id;
  final int exercise_library_id;
  final int sets;
  final int repetitions;
  final double weight;
  final double distance;
  final int duration;
  final String? notes;

  const ExerciseDay({
    this.id,
    required this.exercise_library_id,
    required this.sets,
    required this.repetitions,
    required this.weight,
    required this.distance,
    required this.duration,
    this.notes,
  });

  @override
  List<Object?> get props => [id, exercise_library_id, sets, repetitions, weight, distance, duration, notes];

  ExerciseDay copyWith({
    int? id,
    int? exercise_library_id,
    int? sets,
    int? repetitions,
    double? weight,
    double? distance,
    int? duration,
    String? notes,
  }) {
    return ExerciseDay(
      id: id ?? this.id,
      exercise_library_id: exercise_library_id ?? this.exercise_library_id,
      sets: sets ?? this.sets,
      repetitions: repetitions ?? this.repetitions,
      weight: weight ?? this.weight,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
    );
  }
}