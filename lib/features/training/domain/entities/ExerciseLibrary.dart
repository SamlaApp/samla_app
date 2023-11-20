import 'package:equatable/equatable.dart';

class ExerciseLibrary extends Equatable {
  final int? id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final List<String> secondaryMuscles;

  const ExerciseLibrary({
    this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.instructions,
    required this.secondaryMuscles,
  });

  @override
  List<Object?> get props => [id, name, bodyPart, equipment, gifUrl, target, instructions, secondaryMuscles];

  ExerciseLibrary copyWith({
    int? id,
    String? name,
    String? bodyPart,
    String? equipment,
    String? gifUrl,
    String? target,
    String? instructions,
    List<String>? secondaryMuscles,
  }) {
    return ExerciseLibrary(
      id: id ?? this.id,
      name: name ?? this.name,
      bodyPart: bodyPart ?? this.bodyPart,
      equipment: equipment ?? this.equipment,
      gifUrl: gifUrl ?? this.gifUrl,
      target: target ?? this.target,
      instructions: instructions ?? this.instructions,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
    );
  }
}