import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';

class ExerciseDayModel extends ExerciseDay{
  const ExerciseDayModel({
    required super.id,
    required super.sunday,
    required super.monday,
    required super.tuesday,
    required super.wednesday,
    required super.thursday,
    required super.friday,
    required super.saturday,
    required super.exercise_template_id,
    required super.exercise_library_id,
  });

  @override
  factory ExerciseDayModel.fromJson(Map<String, dynamic> json) {
    return ExerciseDayModel(
      id: json['id'] as int,
      sunday: json['sunday'] as bool,
      monday: json['monday'] as bool,
      tuesday: json['tuesday'] as bool,
      wednesday: json['wednesday'] as bool,
      thursday: json['thursday'] as bool,
      friday: json['friday'] as bool,
      saturday: json['saturday'] as bool,
      exercise_template_id: json['exercise_template_id'] as int,
      exercise_library_id: json['exercise_library_id'] as int,
    );
  }


  factory ExerciseDayModel.fromEntity(ExerciseDay entity) {
    return ExerciseDayModel(
      id: entity.id,
      sunday: entity.sunday,
      monday: entity.monday,
      tuesday: entity.tuesday,
      wednesday: entity.wednesday,
      thursday: entity.thursday,
      friday: entity.friday,
      saturday: entity.saturday,
      exercise_template_id: entity.exercise_template_id,
      exercise_library_id: entity.exercise_library_id,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id as String,
      'sunday': sunday.toString(),
      'monday': monday.toString(),
      'tuesday': tuesday.toString(),
      'wednesday': wednesday.toString(),
      'thursday': thursday.toString(),
      'friday': friday.toString(),
      'saturday': saturday.toString(),
      'exercise_template_id': exercise_template_id.toString(),
      'exercise_library_id': exercise_library_id.toString(),
    };
  }

ExerciseDayModel copyWith({
    int? id,
    bool? sunday,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    int? exercise_template_id,
    int? exercise_library_id,
  }) {
    return ExerciseDayModel(
      id: id ?? this.id,
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      exercise_template_id: exercise_template_id ?? this.exercise_template_id,
      exercise_library_id: exercise_library_id ?? this.exercise_library_id,
    );
  }




}