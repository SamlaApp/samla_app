import 'package:equatable/equatable.dart';

class ExerciseHistory extends Equatable {
  final int? id;
  final int exercise_library_id;
  final int? sets;
  final int? duration;
  final int? repetitions;
  final double? weight;
  final double? distance;
  final String? notes;

  const ExerciseHistory({
    this.id,
    required this.exercise_library_id,
    this.sets,
    this.duration,
    this.repetitions,
    this.weight,
    this.distance,
    this.notes,
  });

  @override
  List<Object?> get props => [id, exercise_library_id, sets, duration, repetitions, weight, distance, notes];
}