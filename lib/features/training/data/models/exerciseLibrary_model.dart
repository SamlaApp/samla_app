import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';

class ExerciseLibraryModel extends ExerciseLibrary{
  const ExerciseLibraryModel({
    required super.id,
    required super.name,
    required super.bodyPart,
    required super.equipment,
    required super.gifUrl,
    required super.target,
    required super.instructions,
    required super.secondaryMuscles,
  });

  @override
  factory ExerciseLibraryModel.fromJson(Map<String, dynamic> json) {
    List<String> secondaryMuscles = [];
    if(json['secondary_muscles'] != null) {
      for (var item in json['secondary_muscles']) {
        secondaryMuscles.add(item['name']);
      }
    }

    return ExerciseLibraryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      bodyPart: json['bodyPart'] as String,
      equipment: json['equipment'] as String,
      gifUrl: json['gifUrl'] as String,
      target: json['target'] as String,
      instructions: json['instructions'] as String,
      secondaryMuscles: secondaryMuscles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bodyPart': bodyPart,
      'equipment': equipment,
      'gifUrl': gifUrl,
      'target': target,
      'instructions': instructions,
      'secondaryMuscles': secondaryMuscles,
    };
  }

  ExerciseLibraryModel copyWith({
    int? id,
    String? name,
    String? bodyPart,
    String? equipment,
    String? gifUrl,
    String? target,
    String? instructions,
    List<String>? secondaryMuscles,
  }) {
    return ExerciseLibraryModel(
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
